class rstudio (
  $ssl_cert,
  $ssl_key,
  $aliases       = [ $::fqdn, ],
  $domain        = $::fqdn,
  $ssl_protocols = undef,
  $ssl_ciphers   = undef,
) {

  # Set up two proxies:
  #   The first forwards port 80 to 443
  #   The second forwards port 443 to rstudio
  class {
    'rstudio::proxy':
      aliases       => $aliases,
      domain        => $domain,
      ssl_key       => $ssl_key,
      ssl_cert      => $ssl_cert,
      ssl_protocols => $ssl_protocols,
      ssl_ciphers   => $ssl_ciphers,
  }

  singleton_resources(
    Package['r-base'],
    Package['rstudio-server'],
    Package['libssl0.9.8'],
    Package['libapparmor1'],
    Package['apparmor-utils'],
  )

  $port = $rstudio::params::port
  $size = $rstudio::params::size
  file {
    '/etc/rstudio/rserver.conf':
      ensure  => file,
      content => template('rstudio/rserver.erb'),
  }

  file {
    '/etc/rstudio/rsession.conf':
      ensure  => file,
      content => template('rstudio/rsession.erb'),
  }

  service {
    'rstudio-server':
      ensure    => running,
      start     => '/usr/sbin/rstudio-server start',
      stop      => '/usr/sbin/rstudio-server stop',
      restart   => '/usr/sbin/rstudio-server restart',
      status    => '/sbin/status rstudio-server',
      require   => Package['rstudio-server'],
      subscribe => [
        File['/etc/rstudio/rserver.conf'],
        File['/etc/rstudio/rsession.conf'],
      ],
  }

}
