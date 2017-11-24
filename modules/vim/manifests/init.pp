class vim {
  #     exec { 'apt-get update':
  #     command => '/usr/bin/yum update'
  #    }

     package { 'vim':
       ensure => 'installed'
       #   require => Exec['apt-get update']
     }
}
