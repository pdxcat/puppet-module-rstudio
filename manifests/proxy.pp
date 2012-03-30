class rstudio::proxy {

    include nginx

    nginx::site {
      "rstudio-proxy":
        domain              => $::fqdn,
        ssl                 => true,
        ssl_certificate     => inline_template("/var/lib/ssl/<%= @fqdn %>.crt"),
        ssl_certificate_key => inline_template("/var/lib/ssl/<%= @fqdn %>.key"),
        timeout             => 120,
        proxy               => true,
        proxy_domain        => '127.0.0.1',
        proxy_port          => $rstudio::params::port,
    }

}
        
