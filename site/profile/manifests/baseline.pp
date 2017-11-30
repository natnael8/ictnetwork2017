class profile::baseline {
  notice('profile::baseline')
  
  class { 'ntp':
    server_list => [ 'mail.ju.edu.et','0.be.pool.ntp.org' ],
  }

  class { 'resolv_conf':
    nameservers => ['8.8.8.8', '10.0.2.3'],
    searchpath  => ['ju.edu.et', 'wireless.UGent.be'],
  }
  class { 'openldap::client':
    base       => 'dc=ju,dc=edu,dc=et',
    uri        => ['ldap://ldap.ju.edu.et', 'ldap://ldap-master.ju.edu.et:666'],
  }

  apt::source { 'puppetlabs':
    location => 'http://apt.puppetlabs.com',
    repos    => 'main',
    key      => {
      'id'     => '6F6B15509CF8E59E6E469F327F438280EF8D349F',
      'server' => 'pgp.mit.edu',
     },
   }

   if($facts[operatingsystem] == 'Debian') {
    apt::source { 'debian':
      ensure   => 'present',
      location => 'http://ftp.be.debian.org/debian',
      repos    => 'main non-free contrib',
     }
   }

   if($facts[operatingsystem] == 'Ubuntu') {
    apt::source { 'ubuntu':
      ensure   => 'present',
      location => 'http://be.archive.ubuntu.com/ubuntu/',
      repos    => 'main restricted universe multiverse ',
     }
    }


   accounts::user { 'natyh':
    uid      => '5012',
    gid      => '4001',
    group    => 'admin',
    shell    => '/bin/bash',
    password => 'Asdf1234',
    locked   => false,
   }
}
