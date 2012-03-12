class rstudio::proxy {

    case $operatingsystem {
        'Ubuntu' : {
            realize(
                Package['nginx'],
            )
        }
    }

    file {
        "/etc/nginx/sites-available/rstudio-proxy.conf":
            ensure  => present,
            content => template("rstudio/nginx-proxy.erb"),
    }

    file {
        "/etc/nginx/sites-enabled/rstudio-proxy.conf":
            ensure  => link,
            target  => "/etc/nginx/sites-available/rstudio-proxy.conf",
            require => "/etc/nginx/sites-available/rstudio-proxy.conf",
    }
}
