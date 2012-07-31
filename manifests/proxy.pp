class rstudio::proxy(
  $domain,
  $aliases,
) {

    include rstudio::params
    include nginx

    nginx::site {
      'rstudio-proxy':
        aliases             => $aliases,
        domain              => $domain,
        ssl                 => true,
        port                => 443,
        ssl_certificate     => inline_template("/var/lib/ssl/<%= @domain %>.crt"),
        ssl_certificate_key => inline_template("/var/lib/ssl/<%= @domain %>.key"),
        keepalive           => 120,
        proxy               => true,
        proxy_domain        => '127.0.0.1',
        proxy_port          => $::rstudio::params::port,
    }

}
