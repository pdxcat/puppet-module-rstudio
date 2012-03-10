class rstudio::params {

    # The port the web server will listen on,
    # the default is 8787
    $::rstudio::port = 8787    
    
    # The maximum file size to upload (in MB)
    $::rstudio::size = 100

    # The admin email for the apache reverse proxy
    $::rstudio::email = 'root@cat.pdx.edu'

}
