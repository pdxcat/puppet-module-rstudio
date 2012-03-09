class rstudio {
    include package::virtual

    include rstudio::params
    include rstudio::apacheconfig

    realize(
        Package['r-base'],
        Package['rstudio-server'],
    )

    file {
        "/etc/rstudio/rserver.conf":
            ensure  => file,
            content => template("rstudio/rserver.erb"),
    }

    file {
        "/etc/rstudio/rsession.conf":
            ensure  => file,
            content => template("rstudio/rsession.erb"),
    }

    exec {
        "/usr/sbin/rstudio-server restart":
            refreshonly => true,
            require => Package['rstudio-server'],
            subscribe => [
                File['/etc/rstudio/rserver.conf'],
                File['/etc/rstudio/rsession.conf'],
            ],
    }

}
