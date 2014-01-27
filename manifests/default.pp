exec { "apt-get update":
  command => "/usr/bin/apt-get update"
}

package { "mysql-server":
  ensure => "installed",
  require => Exec [ "apt-get update" ]
}

package { "wordpress":
  ensure => "installed",
  require => Package [ "mysql-server" ]
}

$clientIP = "10.10.10.2"

exec { "setup-mysql":
  command => "/bin/bash /usr/share/doc/wordpress/examples/setup-mysql -n wordpress $clientIP",
  user => "root",
  require => Package [ "wordpress"]
}

service { "apache2":
  ensure  => "running",
  enable  => "true"
}

exec { "mod rewrite":
  command => "/usr/sbin/a2enmod rewrite",
  user => "root",
  require => Exec [ "setup-mysql" ]
}

exec { "mod vhost_alias":
  command => "/usr/sbin/a2enmod vhost_alias",
  user => "root",
  require => Exec [ "setup-mysql" ]
}

file { "apache conf":
  path => "/etc/apache2/sites-available/wordpress-$clientIP.conf",
  content => template("/vagrant/files/apache.conf"),
  require => Exec [
  	"setup-mysql",
  	"mod rewrite",
  	"mod vhost_alias"
  ]
}

exec { "site default disabled":
  command => "/usr/sbin/a2dissite default",
  user => "root",
  require => Package [ "wordpress" ]
}

exec { "site wordpress":
  command => "/usr/sbin/a2ensite wordpress-$clientIP.conf",
  user => "root",
  require => [
    Exec [ "site default disabled" ],
    File [ "apache conf" ]
  ],
  notify => Service [ "apache2" ]
}