class rc {
  # for sure we have logger and RC on this distros
  if ($operatingsystem == "Ubuntu") or ($operatingsystem == "Debian") {
    file { "/etc/rc.local":
      content => template("rc/rc.local"),
    }
  }
}
