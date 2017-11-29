class profile::openldap {

 class { 'ldap::server':
  suffix     => 'dc=ju,dc=edu,dc=et',
  rootdn     => 'cn=admin,dc=ju,dc=edu,dc=et',
  rootpw     => 'llama',
 }

 class openldap::utils(
   $package = $openldap::params::utils_package,
 ) inherits ::openldap::params {
   if $package {
     package { $package:
       ensure => present,
     }
   }
 }

}
