import "nodejs.pp"

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
  refreshonly => true,
  subscribe => Package [ "wordpress" ]
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
  require => File [ "/opt/phantomjs/" ],
  creates => "/opt/phantomjs/phantomjs.tar.bz2"
}

exec { "install phantomjs":
  command => "/bin/tar -jxvf /opt/phantomjs/phantomjs.tar.bz2 -C /opt/phantomjs/ --strip-components 1",
  user => "root",
  require => Exec [ "download phantomjs" ],
  creates => "/opt/phantomjs/bin/phantomjs"
}

file { "/usr/bin/phantomjs":
  ensure => link,
  target => "/opt/phantomjs/bin/phantomjs",
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
  require => [
    Exec [ "download casperjs" ],
    File [ "/usr/bin/phantomjs" ]
  ]
}

$version = "0.6"

file { "/vagrant/theme/style.css":
  content => template("/vagrant/files/style.css"),
  ensure => "present"
}

file { "/vagrant/target/package.sh":
  content => template("/vagrant/files/package.sh"),
  ensure => "present",
  mode => "0766"
}

$login = "admin"
$password = "admin"

file { "deploy casper wordpress installation":
  path => "/tmp/casper-wordpress-installation.js",
  content => template("/vagrant/files/casper-wordpress-installation.js"),
  require => Exec [ "site wordpress", "install casperjs" ]
}

exec { "casper wordpress installation":
  command => "/opt/casperjs/bin/casperjs test /tmp/casper-wordpress-installation.js",
  logoutput => "on_failure",
  require => File [ "deploy casper wordpress installation" ]
}

file { "/usr/share/wordpress/wp-content/themes/valtech":
  ensure => link,
  target => "/vagrant/theme",
  require => Package [ "wordpress" ]
}

include nodejs

exec { "install bower":
  command => "/usr/bin/npm install -g bower",
  user => "root",
  logoutput => true,
  require => Class [ "nodejs" ],
  unless => "/usr/bin/file /usr/bin/bower"
}

package { "git":
  ensure => "installed",
  require => Exec [ "apt-get update" ]
}

exec { "build theme":
  cwd => "/vagrant/",
  command => "/bin/sh /vagrant/build.sh",
  logoutput => "on_failure",
  require => [
    File [ "/usr/share/wordpress/wp-content/themes/valtech" ],
    Exec [ "casper wordpress installation", "install bower" ],
    Package [ "git" ]
  ]
}

file { "deploy casper activate theme":
  path => "/tmp/casper-activate-theme.js",
  content => template("/vagrant/files/casper-activate-theme.js"),
  require => Exec [ "build theme" ]
}

exec { "casper activate theme":
  command => "/opt/casperjs/bin/casperjs test /tmp/casper-activate-theme.js",
  logoutput => "on_failure",
  require => File [ "deploy casper activate theme" ]
}

package { "unzip":
  ensure => installed,
  require => Exec [ "apt-get update" ]
}