class grunt {

  # house keeping
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update',
  }

  package { 'curl':
    ensure => present,
    require => Exec['apt-get update'],
  }

  package { 'python-software-properties':
    ensure => present,
    require => Exec['apt-get update'],
  }

  package { 'ruby1.9.3':
    ensure => present,
    require => Exec['apt-get update'],
  }

  # Get node
  exec { 'add node repo':
    command => '/usr/bin/apt-add-repository ppa:chris-lea/node.js && /usr/bin/apt-get update',
    require => Package['python-software-properties'],
  }

  package { 'nodejs':
    ensure => latest,
    require => [Exec['apt-get update'], Exec['add node repo']],
  }


  # install npm
  exec { 'npm':
    command => '/usr/bin/curl https://npmjs.org/install.sh | /bin/sh',
    require => [Package['nodejs'], Package['curl']],
    environment => 'clean=yes',
  }

  # install sass
  exec { 'gem install sass':
    command => '/usr/bin/gem install sass',
    require => Package['ruby1.9.3'],
  }

  # install compass
  exec { 'gem install compass':
    command => '/usr/bin/gem install compass',
    require => Package['ruby1.9.3'],
  }

  # install susy
  exec { 'gem install susy':
    command => '/usr/bin/gem install susy',
    require => Package['ruby1.9.3'],
  }

  # create symlink to stop node-modules foler breaking
  exec { 'node-modules symlink':
    command => '/bin/rm -rfv /usr/local/node_modules && /bin/rm -rfv /vagrant/node_modules && /bin/mkdir /usr/local/node_modules && /bin/ln -sf /usr/local/node_modules /vagrant/node_modules ',
  }

  # finally install grunt
  exec { 'npm install -g grunt-cli bower':,
    command => '/usr/bin/npm install -g grunt-cli bower',
    require => Exec['npm'],
  }
}
