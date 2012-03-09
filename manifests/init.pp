class rstudio {
    include package::virtual

    realize(
        Package['r-base'],
        Package['rstudio-server'],
    )

    # The port the web server will listen on,
    # the default is 80
    $rstudio_port = 80    
    file {
        "/etc/rstudio/rserver.conf":
            ensure => present,
            source => template("rstudio/rserver.erb"),
    }

    # The maximum file size to upload (in MB)
    $rstudio_size = 100
    file {
        "/etc/rstudio/rsession.conf":
            ensure => present,
            source => template("rstudio/rsession.erb"),
    }

    service {
        "rstudio":
            enable => true,
            ensure => running,
            hasrestart => true,
            hasstatus => true,
            require => Package['rstudio-server'],
            subscribe => [
                File['/etc/rstudio/rserver.conf'],
                File['/etc/rstudio/rsession.conf'],
            ],
    }

}
