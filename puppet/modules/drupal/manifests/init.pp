#
include aegir
class drupal {

  file { "/var/aegir/drupal_core.make":
    content => template("drupal/drupal_core.make"),
    require => Class['aegir:dev'],
    group => "aegir",
    owner => "aegir",
  }
  aegir::platform{ 
    'drupal-7.25',
    makefile => '/var/aegir/drupal_core.make',
  }
}
