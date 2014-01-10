
class puppet::master::service (
  $service = 'puppetmaster',
  $ensure  = true,
  $enable = true,
  $hasstatus = true,
  $hasrestart = true,
) {
  service { $service:
    ensure     => $ensure,
    enable     => $enable,
    hasstatus  => $hasstatus,
    hasrestart => $hasrestart,
    subscribe  => Class['puppet::config'],
  }
}
