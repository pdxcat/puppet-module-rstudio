class rstudio::apacheconfig {

    realize (
        Package['httpd'],
    )
    
    include apache

    # The admin email for the apache reverse proxy
    $email = 'root@cat.pdx.edu'

    file {
        "/etc/apache2/httpd.conf":
            ensure  => present,
            content => template("rstudio/httpd.erb"),
            require => Package['httpd'],
            notify  => Service['httpd'],
    }
}
