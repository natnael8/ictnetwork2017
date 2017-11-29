# @since 1.7.0
function bodgitlib::enclose_ipv6(Bodgitlib::Host $host) {

  type($host) ? {
    Type[IP::Address::V6::NoSubnet] => "[${host}]",
    default                         => $host,
  }
}
