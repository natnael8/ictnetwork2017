node default {
     class { 'ntp':
      }
}	
node 'natnael.puppetlabs.vm' {
#	include apache
#  	include systemsusers
#  	include vim
#	include ntp
  class { 'openldap::server': 
    openldap::server::database { 'dc=juldap,dc=example.com':
  	ensure => present,
        }
        provider => 'augeas',
    openldap::server::database { 'dc=ju,dc=edu,dc=et':
        directory => '/var/lib/ldap',
        rootdn    => 'cn=admin,dc=ju,dc=edu,dc=et',
        rootpw    => 'secret',
        }
        }
}
