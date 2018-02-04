class isc_dhcpd (
  String  $domain_name,
  Array   $domain_name_servers,
  Integer $default_lease_time,
  Integer $max_lease_time,
  String  $ddns_update_style,
  Boolean $authoritative,
  String  $log_facility,
  Array   $subnets,
  Array   $hosts,
  Array   $classes,
  Array   $shared_networks,
) {
  $dhcpd_pkg = 'dhcp'
  $dhcpd_svc = 'dhcpd'
  $dhcpd_cfg = '/etc/dhcp/dhcpd.conf'
  package { $dhcpd_pkg:
    ensure => installed,
  }
  file { $dhcpd_cfg:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package[$dhcpd_pkg],
    notify  => Service[$dhcpd_svc],
    content => template('isc_dhcpd/dhcpd.conf.erb'),
  }
  service { $dhcpd_svc:
    ensure  => running,
    enable  => true,
    require => Package[$dhcpd_pkg],
  }
}
