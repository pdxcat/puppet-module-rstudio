class rstudio {
    include package::virtual

    # The port rstudio will listen on,
    # the default is 8787
    $port = 8787    
    
    # The maximum file size to upload (in MB)
    $size = 100

    # Set up two proxies:
    #   The first forwards port 80 to 443
    #   The second forwards port 443 to rstudio
    include rstudio::proxy


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

    service {
        case $::operatingsystem {
            'Ubuntu': {
                provider => 'upstart',
            }
        }
        ensure      => 'running',
        require     => Package['rstudio-server'],
        subscribe   => [
            File['/etc/rstudio/rserver.conf'],
            File['/etc/rstudio/rsession.conf'],
        ],
    }

}
