# ntp/manifests/init.pp - Classes for configuring NTP
# Copyright (C) 2007 David Schmitt <david@schmitt.edv-bus.at>
# See LICENSE for the full license granted to you.

	
class ntp ($ntp_server, $ntpconf = 'ntp/ntp.conf.erb') {

  $ntp_package = $::lsbdistcodename ? { 'sarge' => 'ntp-server', default => 'ntp' }
  $ntp_pattern = $::operatingsystem ? { 'Debian' => 'ntpd', 'RedHat' => "ntpd", default => 'ntp' }
  $ntp_servicename = $::operatingsystem ? { 'RedHat' => "ntpd", 'CentOs' => "ntpd", default => 'ntp' }

  if $::operatingsystem != "Solaris"
  {
    package {
      $ntp_package:
        ensure => installed,
        before => File["ntp.conf"],
        notify => Service[$ntp_servicename]
    }
  }

  service{ $ntp_servicename:
          ensure  => running,
          enable  =>  true,
          pattern => $ntp_pattern
  }

  file { "ntp.conf":
    path => $::operatingsystem ? {
      "Solaris" => "/etc/inet/ntp.conf",  
      default => "/etc/ntp.conf",  
    },
    owner => "root",
    group => "root",
    mode  => 644,
    content => template($ntpconf),
    ensure => present,
  }
}
