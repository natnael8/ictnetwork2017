class profile::openldap {
  notice('profile::ju_ldap')
  
  class { 'openldap::server': }

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
#  openldap::server::schema { 'samba':
#   ensure  => present,
#   path    => '/etc/ldap/schema/samba.schema',
#   require => Openldap::Server::Schema["inetorgperson"],
#  }

#  openldap::server::schema { 'nis':
#   ensure  => present,
#   path    => '/etc/ldap/schema/nis.ldif',
#   require => Openldap::Server::Schema["inetorgperson"],
#  }

}
