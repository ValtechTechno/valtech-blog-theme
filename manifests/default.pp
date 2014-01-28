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

file { "/opt/phantomjs/":
  ensure => directory
}

exec { "download phantomjs":
  command => "/usr/bin/wget -O /opt/phantomjs/phantomjs.tar.bz2 https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.6-linux-i686.tar.bz2",
  user => "root",
  require => File [ "/opt/phantomjs/" ]
}

exec { "install phantomjs":
  command => "/bin/tar -jxvf /opt/phantomjs/phantomjs.tar.bz2 -C /opt/phantomjs/ --strip-components 1",
  user => "root",
  require => Exec [ "download phantomjs" ]
}

exec { "add phantomjs binary":
  command => "/bin/ln -s /opt/phantomjs/bin/phantomjs /usr/bin/phantomjs",
  user => "root",
  require => Exec [ "install phantomjs" ]
}

file { "/opt/casperjs/":
  ensure => directory
}

exec { "download casperjs":
  command => "/usr/bin/wget -O /opt/casperjs/casperjs.tar.gz https://github.com/n1k0/casperjs/tarball/1.1-beta3",
  user => "root",
  require => File [ "/opt/casperjs/" ]
}

exec { "install casperjs":
  command => "/bin/tar -zxvf /opt/casperjs/casperjs.tar.gz -C /opt/casperjs/ --strip-components 1",
  user => "root",
  require => Exec [ "add phantomjs binary", "download casperjs" ]
}