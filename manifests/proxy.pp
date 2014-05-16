class rstudio::proxy(
  $domain,
  $aliases,
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
    ssl                  => true,
    ssl_cert             => "/var/lib/ssl/${domain}.crt",
    ssl_key              => "/var/lib/ssl/${domain}.key",
    use_default_location => false,
  }

  nginx::resource::location { '/-nossl':
    location                   => '/',
    ensure                     => present,
    vhost                      => $domain,
    location_custom_cfg        => {
      'return' => "301 https://${domain}\$request_uri"
    },
  }
  
  nginx::resource::location { '/':
    ensure                     => present,
    ssl                        => true,
    ssl_only                   => true,
    vhost                      => $domain,
    proxy                      => 'http://rstudio_upstream',
  }
}
