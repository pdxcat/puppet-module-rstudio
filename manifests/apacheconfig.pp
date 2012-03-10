class rstudio::apacheconfig {

    case $operatingsystem {
        'Ubuntu' : {
            realize(
                Package['apache2'],
            )
        }
    }

    # The admin email for the apache reverse proxy
    $email = 'root@cat.pdx.edu'

    file {
        "/etc/apache2/httpd.conf":
            ensure  => present,
            content => template("rstudio/httpd.erb"),
    }
}
