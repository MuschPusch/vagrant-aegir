node 'aegir.local' {

  include grunt
  include apt
  include phpmyadmin
  include tuningprimer
  # include vim #broken
  include phpmyadmin

  package { ['git', 'tig']:
    ensure => present,
  }


  # install drush
  class {'drush::git::drush':
    git_branch => '5.x',
    update     => true,
    require => Package['git'],
  }

  class { 'aegir::dev' :
    hostmaster_ref => '6.x-2.x',
    provision_ref  => '6.x-2.x',
    platform_path  => '/var/aegir/hostmaster-6.x-2.x',
    require        => Class['drush::git::drush'],
  }


  exec { "grep":
    command => "grep -q 'sleep 8; apache2ctl start' /etc/init.d/rc.local || /bin/echo 'sleep 8; apache2ctl start' >> /etc/init.d/rc.local",
    require => Class['aegir::dev'],
  }

  class{ 'php':
    require => Class['drush::git::drush'],
  }
}

# we need to wait a bit since apache should only start when NFS is enabled
# otherwise some .htaccess files which are required won't be available

include rc # needs work. We should mount BindFS using puppet
include pearpackages

# This is in the defaults that is included in aegir::platform...
# I'm not sure why it isn't inherited properly from there.
Drush::Run {
  site_alias => '@hostmaster',
  drush_user => 'aegir',
  drush_home => '/var/aegir',
  log        => '/var/aegir/drush.log',
}
