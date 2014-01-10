define apt::sources(
    $release = $name,
  ){

  file {"/etc/apt/sources.list.d/${release}.list":
    content => template('apt/sources.erb'),
    owner   => root,
    group   => root,
    mode    => 644,
  }
  Apt::Sources <| |> -> Exec['apt_update']
}
