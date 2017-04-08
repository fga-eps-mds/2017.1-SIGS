class git {

  package { "git-core":
    ensure  => present,
    require => Class["system-update"],
  }

}
