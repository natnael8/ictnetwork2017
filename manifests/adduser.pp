node 'stretch' {

  accounts::user { 'natyh':
    uid      => '5012',
    gid      => '4001',
    group    => 'admin',
    shell    => '/bin/bash',
    password => 'Asdf1234',
    locked   => false,
   }
}
