node default {

  class { 'openldap::client': 
   base       => 'dc=ju,dc=edu,dc=et',
   uri        => ['ldap://ldap.ju.edu.et', 'ldap://ldap-master.ju.edu.et:3899'],
   tls_cacert => '/etc/ssl/certs/ca-certificates.crt',

  }

}

##ldap server
node 'stretch' {

  class { 'openldap::server': }
   openldap::server::database { 'dc=ldap,dc=ju.edu.et':
   ensure => present,
  }
  
  class { 'openldap::server':
   ldaps_ifs => ['/'],
   ssl_cert  => '/etc/ldap/ssl/slapd.pem',
   ssl_key   => '/etc/ldap/ssl/slapd.key',
  }
  
  class { 'openldap::server':
   provider => 'augeas',
  }
  
  openldap::server::globalconf { 'security':
   ensure => present,
   value  => 'tls=128',
  }
  
  openldap::server::globalconf { 'Security':
   ensure  => present,
	value   => { 'Security' => [ 'simple_bind=128', 'ssf=128', 'tls=0' ] } 

  
   }

  openldap::server::database { 'dc=ju,dc=edu,dc=et':
    directory => '/var/lib/ldap',
    rootdn    => 'cn=admin,dc=ju,dc=edu,dc=et',
    rootpw    => 'secret',
  }

  ###Configuring modules
  openldap::server::module { 'memberof':
   ensure => present,
  }

  ###Configuring overlays
  openldap::server::overlay { 'memberof on dc=ju,dc=edu,dc=et':
   ensure => present,
  }

  ###Configuring Schemas
  openldap::server::schema { 'samba':
   ensure  => present,
   path    => '/etc/ldap/schema/samba.schema',
   require => Openldap::Server::Schema["inetorgperson"],
  }

  openldap::server::schema { 'nis':
   ensure  => present,
   path    => '/etc/ldap/schema/nis.ldif',
   require => Openldap::Server::Schema["inetorgperson"],
  }
}
