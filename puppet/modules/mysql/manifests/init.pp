class mysql {

  package { ["mysql-server","libmysqlclient-dev"]:
    ensure  => present,
    require => Class["system-update"],
  }
}

class phpmyadmin {
  package { "phpmyadmin":
    ensure  => present,
    require => Class["system-update"],
  }

	exec{ 'echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf': 
	command => 'echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf',
	require => Package['apache2'],
    }

	exec{ 'cp /vagrant/config.inc.php /etc/phpmyadmin/config.inc.php':
	command => 'cp /vagrant/config.inc.php /etc/phpmyadmin/config.inc.php',
	notify  => Service['apache2'], 
	require => Package['phpmyadmin'],
	}

}
