class profile::openldap {
  
#  include ::openldap
#  include ::openldap::client
 
  class { '::openldap':
    tls_cacertdir => '/etc/openldap/certs'
  }
   
  include ::openldap::client
 
  ::openldap::configuration { '/etc/skel/.ldaprc':
   ensure => file,
   owner  => 0,
   group  => 0,
   mode   => '0640',
   base   => 'dc=ju,dc=edu,dc=et',
   uri    => ['ldap://ldap.ju.edu.et/'],
  }

  ::Openldap::Configuration['/etc/skel/.ldaprc'] -> User <||>

  class { '::openldap::server':
   root_dn       => 'cn=admin,dc=ju,dc=edu,dc=et',
   root_password => '{SSHA}7dSAJPGe4YKKEvUPuGJIeSL/03GV2IMY',
   suffix        => 'dc=ju,dc=edu,dc=cet',
   access        => [
     [
       {
         'attrs' => ['userPassword'],
       },
       [
         {
           'who'    => ['self'],
           'access' => '=xw',
         },
         {
           'who'    => ['anonymous'],
           'access' => 'auth',
         },
       ],
     ],
     [
       {
         'dn' => '*',
       },
       [
         {
           'who'    => ['dn.base="gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth"'],
           'access' => 'manage',
         },
         {
           'who'    => ['self'],
           'access' => 'write',
         },
         {
           'who'    => ['users'],
           'access' => 'read',
         },
       ],
     ],
   ],
   indices       => [
     [['objectClass'], ['eq', 'pres']],
     [['ou', 'cn', 'mail', 'surname', 'givenname'], ['eq', 'pres', 'sub']],
   ],
   interfaces    => ["ldap://${::ipaddress}/"],
 }
 ::openldap::server::schema { 'cosine':
   ensure => present,
 }
 ::openldap::server::schema { 'inetorgperson':
   ensure => present,
 }
 ::openldap::server::schema { 'nis':
   ensure  => present,
   require => ::Openldap::Server::Schema['cosine'],
 }

}
