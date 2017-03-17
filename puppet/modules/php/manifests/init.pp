class php {

  package { "php5":
    ensure  => present,
    require => Class["system-update"],
  }
}

class libapache2 {

  package { "libapache2-mod-php5":
    ensure  => present,
    require => Class["system-update"],
  }
}

class php5_mcrypt{
   package { "php5-mcrypt":
    ensure  => present,
    require => Class["system-update"],

  }
}
