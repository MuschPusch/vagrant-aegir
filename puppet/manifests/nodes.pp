node 'aegir.local' {

#  include grunt # needs work
  include apt
  include vim
  include phpmyadmin 

  package { ['git', 'tig']:
    ensure => present,
  }

#  package { 'jenkins':
#    ensure => present,
#  }

  class { 'drush::git::drush':
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


# This is in the defaults that is included in aegir::platform...
# I'm not sure why it isn't inherited properly from there.
Drush::Run {
  site_alias => '@hostmaster',
  drush_user => 'aegir',
  drush_home => '/var/aegir',
  log        => '/var/aegir/drush.log',
}

#  THIS SHOULD ONLY BE RUN AFTER AEGIR IS INSTALLED AND NFS IS ENABLED
#aegir::platform {'Drupal7':
#  makefile => '/vagrant/drupal_core.make',
#}
