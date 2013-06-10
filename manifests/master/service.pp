
class puppet::master::service (
  $service = 'puppetmaster',
  $ensure  = true,
  $enable = true,
) {
  service { $service:
    ensure     => $ensure,
    enable     => $enable,
    hasstatus  => true,
    hasrestart => true,
    subscribe  => Class['puppet::config'],
  }
}
