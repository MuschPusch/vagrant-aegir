class rc {
#we need to do this for every user
# or we change vimrc to not being global anymore
  if ($operatingsystem == "Ubuntu") or ($operatingsystem == "Debian") {
    package { "logger":
      ensure => present,
    }
  }

  file { "/etc/rc.local":
    content => template("rc/rc.local"),
    require => Package['logger'],
  }
}
