class nodejs {
  exec { "apt-get update":
    command => "/usr/bin/apt-get update",
    user => root
  }

  package { "python-software-properties":
    ensure => installed,
    require => Exec [ "apt-get update" ]
  }

  exec { "add nodejs ppa":
    command => "/usr/bin/apt-add-repository ppa:chris-lea/node.js",
    require => Package [ "python-software-properties"],
    notify => Exec [ "apt-get update after ppa" ]
  }

  exec { "apt-get update after ppa":
    command => "/usr/bin/apt-get update",
    user => root
  }

  package { "nodejs":
    ensure => "installed",
    require => Exec [ "apt-get update after ppa" ]
  }
}