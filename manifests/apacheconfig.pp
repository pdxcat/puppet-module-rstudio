class rstudio::apacheconfig {
    include apache

    # The admin email for the apache reverse proxy
    $email = 'root@cat.pdx.edu'

    file {
        "/etc/apache2/httpd.conf":
            ensure  => present,
            content => template("rstudio/httpd.erb"),
    }
}
