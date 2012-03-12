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

}
