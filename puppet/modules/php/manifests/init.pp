# Install some extra php libraries and configure php.
#
#  extra php modules can be passed for installation

class php(
    $modules = [],
  ){

  include apt
  # Install some extras
  package {['php5-cli', 'php5-gd', 'php5-curl']:
      require => Package['php5'],
  }

  # Setup some dependencies.
  Package['php5-common'] -> Package['libapache2-mod-php5'] -> Package['php5-cli'] -> Package['php5']

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
    notify  => Service['apache2'],
    require => [Package['apache2'], Package['php5']],
  }

  file {"/etc/php5/cli/php.ini":
    ensure  => present,
    source  => 'puppet:///modules/php/php-cli.ini',
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    notify  => Service['apache2'],
    require => [Package['apache2'], Package['php5']],
  }
}
