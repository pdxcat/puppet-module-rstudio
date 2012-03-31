class rstudio::proxy {

    include nginx

    nginx::site {
      "rstudio-proxy":
        domain              => 'barbados.cat.pdx.edu',
        ssl                 => true,
        ssl_certificate     => "/var/lib/ssl/barbados.cat.pdx.edu.crt",
        ssl_certificate_key => "/var/lib/ssl/barbados.cat.pdx.edu.key",
        keepalive           => 120,
        proxy               => true,
        proxy_domain        => '127.0.0.1',
        proxy_port          => '8787',
    }

}
        
