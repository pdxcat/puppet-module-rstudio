class rstudio::apacheconfig {
    include apache

    file {
        "/etc/apache2/httpd.conf":
            ensure  => present,
            content => template("rstudio/httpd.erb"),
    }
}
