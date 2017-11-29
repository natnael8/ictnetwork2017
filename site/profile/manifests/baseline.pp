class profile::baseline {
  notice('profile::baseline')
  
  class { 'ntp':
    server_list => [ 'mail.ju.edu.et','0.be.pool.ntp.org' ],
  }

  class { 'resolv_conf':
    nameservers => ['8.8.8.8', '10.0.2.3'],
    searchpath  => ['ju.edu.et', 'wireless.UGent.be'],
  }

}
