class role::ju_ldap {
  notice('role::ju_ldap')
  
  include ::profile::baseline
  include ::profile::openldap

}
