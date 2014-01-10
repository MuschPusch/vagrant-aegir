class vim {
#we need to do this for every user
# or we change vimrc to not being global anymore
  if ($operatingsystem == "Ubuntu") or ($operatingsystem == "Debian") {
    package { "vim-nox":
      ensure => present,
    }
  }

  # Ignore git files for bundles as git submodules:
  File { ignore => '.git' }

  file { "/etc/vim/vimrc":
    content => template("vim/vimrc.erb"),
    require => Package['vim-nox'],
  }

  file { ["/var/aegir/.vim/", "/var/aegir/.vim/bundle/"]:
    ensure => "directory",
    group => "aegir",
    owner => "aegir",
    require => [Package['vim-nox'], File["/etc/vim/vimrc"]],
  }

  file {['/var/aegir/.vim/bundle/vundle']:
    source => "puppet:///modules/vim/vundle",
    recurse => true,
    group => "aegir",
    owner => "aegir",
    mode => 644,
    require => [ File["/etc/vim/vimrc"],File["/var/aegir/.vim/bundle/"] ],
  }

  exec { "vim":
    command => "/usr/bin/vim +BundleInstall +qall",
    require => Package['vim-nox'],
    returns => [ 1, '', ' '],
  }
}
