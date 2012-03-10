class rstudio::apacheconfig {
    include apache

    include rstudio::params

    file {
        "/etc/apache2/httpd.conf":
            ensure  => present,
            content => template("rstudio/httpd.erb"),
    }
}
