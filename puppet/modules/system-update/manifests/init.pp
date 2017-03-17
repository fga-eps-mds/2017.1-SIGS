class system-update {

  exec { 'apt-get update':
    command => 'apt-get update',
  }

  $sysPackages = [ "build-essential", "autoconf", "bison", "libssl-dev", "libyaml-dev", "libreadline6-dev", "zlib1g-dev", "libncurses5-dev", "libffi-dev", "libgdbm-dev" ]
  package { $sysPackages:
    ensure => "installed",
    require => Exec['apt-get update'],
  }
}
