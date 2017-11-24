node default {
   class { 'ntp':

   }

}

  node 'natnael.puppetlabs.vm' {
	include apache
  #include systemsusers
  #include vim
}
