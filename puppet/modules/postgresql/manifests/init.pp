class postgresql{

	$postgresqlPackages = ['postgresql','libpq-dev']
	package { $postgresqlPackages:
    	ensure  => present,
    	require => Class["system-update"]
	}
}