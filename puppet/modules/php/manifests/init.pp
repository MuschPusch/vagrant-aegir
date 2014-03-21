# Install some extra php libraries and configure php.
#
#  extra php modules can be passed for installation

class php(
    $modules = [],
  ){

  include apt
  # Install some extras
  package {['php5-curl', 'php5-xdebug', 'php-apc']:
      require => Package['php5'],
  }

  if $modules != [] {
    # Install other requested packages.
    package {$modules:
      require => Package['php5'],
    }
  }

  file {"/etc/php5/apache2/php.ini":
    ensure  => present,
    source  => 'puppet:///modules/php/php.ini',
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    #TODO: add nginx support + aegir::dev doesn't seem to add webservers as services
    #notify  => Service['apache'],
    require => [Package['apache2'], Package['php5']],
  }

  file {"/etc/php5/cli/php.ini":
    ensure  => present,
    source  => 'puppet:///modules/php/php-cli.ini',
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    #TODO: add nginx support + aegir::dev doesn't seem to add webservers as services
    #notify  => Service['apache'],
    require => [Package['apache2'], Package['php5']],
  }
  # Change user
  exec { "ApacheUserChange" :
      command => "sed -i 's/APACHE_RUN_USER=www-data/APACHE_RUN_USER=aegir/' /etc/apache2/envvars",
      onlyif  => "grep -c 'APACHE_RUN_USER=www-data' /etc/apache2/envvars",
      require => Package["apache2"],
      notify  => Service["apache2"],
  }

  # Change group
  exec { "ApacheGroupChange" :
      command => "sed -i 's/APACHE_RUN_GROUP=www-data/APACHE_RUN_GROUP=aegir/' /etc/apache2/envvars",
      onlyif  => "grep -c 'APACHE_RUN_GROUP=www-data' /etc/apache2/envvars",
      require => Package["apache2"],
      notify  => Service["apache2"],
  }

}
