class system_users::admins {
  user{'natyhm':
      ensure =>present,
      gid => 'sysadmin',
  }
  group {'sysadmin':
      ensure => present,
      gid  => '5000',
  }
}
