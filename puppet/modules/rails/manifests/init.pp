class rails{
	$sysPackages = [ "nodejs", "curl"]
	package { $sysPackages:
    	ensure  => present,
    	require => Class["system-update"],
  }
}

class curl{
	
	exec{ 'gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3': 
	command => 'gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3',
	require => Class['rails'],
    }
       
}