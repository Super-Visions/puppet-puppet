
class puppet::master::package (
  $package = 'puppet-server',
  $ensure = 'installed',
) {
  package { $package:
    ensure => $ensure,
  }
}
