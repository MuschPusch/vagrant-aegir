#http://blog.code4hire.com/2013/01/pear-packages-installation-under-vagrant-with-puppet/
class pearpackages {

  package { 'php-pear':
    ensure => present,
  }

  exec {"pear upgrade":
    command => "/usr/bin/pear upgrade",
    require => Package['php-pear'],
    #returns => [ 0, '', ' ']
  }

# set channels to auto discover
  exec { "pear auto_discover" :
    command => "/usr/bin/pear config-set auto_discover 1",
    require => [Package['php-pear']]
  }

  exec { "pear update-channels" :
    command => "/usr/bin/pear update-channels",
    require => [Package['php-pear']]
  }

  exec {"pear install Console_Table":
    command => "/usr/bin/pear install --alldeps Console_Table",
    #creates => '/usr/bin/phpunit',
    require => Exec['pear update-channels']
  }
}
