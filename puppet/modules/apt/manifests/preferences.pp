define apt::preferences(
    $release,
    $packages,
    $filename = $name,
    $priority = '991',
  ){
  file {"/etc/apt/preferences.d/${filename}":
    ensure => file,
    content => template('apt/preferences.erb'),
    owner   => root,
    group   => root,
    mode    => 644,
  }
  Apt::Preferences <| |> -> Exec['apt_update']
}
