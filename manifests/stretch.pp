node 'stretch' {

 include ::role::ju_ldap

} 

node 'stretch_old' {
  class { '::postfix':
    relayhost => 'smtp.ugent.be',
  #  myorigin => $::fqdn,
  }


  class { 'rsync': 
    package_ensure => 'latest' 
  }
  
 # rsync::get { '/foo':
 #   source => "rsync://${rsyncServer}/repo/foo/",
 #   require => File['/foo'],
 # }
  
 # rsync::put { '${rsyncDestHost}:/repo/foo':
 #  user    => 'root',
 #  source  => "/repo/foo/",
 # }
  
 # rsync::server::module{ 'repo':
 #  path    => $base,
 #  require => File[$base],
 # }

  include ssh::client
  
  class { 'ssh::server':
    password_authentication => 'yes',
  }  
  
  ssh::user { 'natyh':
   key     => 'a8a7dgf7ad8j13g',
   comment => 'laptop',
  } 

 # ssh::user { 'laptop':
 #  key  => 'a8a7dgf7ad8j13g',
 #  user => 'natyh',
 # }	


  class { 'ntp':
    server_list => [ 'mail.ju.edu.et','0.be.pool.ntp.org' ],
  }

  class { 'resolv_conf':
    nameservers => ['10.140.5.25', '10.0.2.3'],
    searchpath  => ['ju.edu.et', 'wireless.UGent.be'],
  }

  class { 'apt':
    update => {
      frequency => 'daily',
    },
    purge => {
      'sources.list'   => true,
      'sources_list.d' => true,
      'preferences'    => true,
      'preferences.d'  => true,
    },
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

}

node 'openldap'
{

}

