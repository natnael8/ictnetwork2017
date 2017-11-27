node 'stretch'{
  class { 'apt':
    update => {
      frequency => 'daily',
    },
    purge => {
      sources_list   => true,
      'sources_list.d' => true,
      preferences    => true,
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


}

node 'openldap'
{

}

