class vim {
  if ($operatingsystem == "Ubuntu") or ($operatingsystem == "Debian") {
    package { "vim-nox":
      ensure => present,
    }
  }

  # Ignore git files for bundles as git submodules:
  File { ignore => '.git' }

  file { "/etc/vim/vimrc":
    content => template("vim/vimrc.erb"),
  }

  file { "/home/vagrant/.vim/bundle/":
    ensure => "directory",
    group => "vagrant",
    owner => "vagrant",
  }

  file {'/home/vagrant/.vim/bundle/vundle':
    source => "puppet:///modules/vim/vundle",
    recurse => true,
    group => "vagrant",
    owner => "vagrant",
    mode => 644,
    require => File["/etc/vim/vimrc"],
  }

  exec { "vim":
    command => "/usr/bin/vim +BundleInstall +qall",
  }
}
