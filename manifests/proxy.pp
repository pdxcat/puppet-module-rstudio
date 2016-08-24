class rstudio::proxy(
  $domain,
  $aliases,
  $ssl_key,
  $ssl_cert,
  $ssl_protocols = undef,
  $ssl_ciphers   = undef,
) {

  include ::rstudio::params
  include ::nginx

  ##TODO: Make aliases work again

  nginx::resource::upstream { 'rstudio_upstream':
    members => [
      "localhost:${::rstudio::params::port}",
    ],
  }

  nginx::resource::vhost { $domain:
    ipv6_enable          => true,
    ssl                  => true,
    ssl_cert             => $ssl_cert,
    ssl_key              => $ssl_key,
    ssl_protocols        => $ssl_protocols,
    ssl_ciphers          => $ssl_ciphers,
    use_default_location => false,
  }

  nginx::resource::location { '/-nossl':
    ensure              => present,
    location            => '/',
    vhost               => $domain,
    location_custom_cfg => {
      'return' => "301 https://${domain}\$request_uri"
    },
  }

  nginx::resource::location { '/':
    ensure   => present,
    ssl      => true,
    ssl_only => true,
    vhost    => $domain,
    proxy    => 'http://rstudio_upstream',
  }
}
