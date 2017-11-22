class vim {
     exec { 'apt-get update':
       command => '/usr/bin/apt-get update'
      }

     package { 'vim':
       ensure => 'installed'
     require => Exec['apt-get update']
     }
}
