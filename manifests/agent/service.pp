#
# == Class: puppet::agent::service
#
# The puppet::agent::service class manages the 
# puppet agent service resource
#
# === Parameters
#
# This class does not take parameters as all parameters are fetched via hiera
# The parameter defaults are stored in the puppet::data class
#
# === Variables
#
# [*agent_service*]
#   the service name  is fetched from puppet::data via
#   the puppet_backend for Hiera. It can be overridden by 
#   specyfying a different value in an applicable hiera file.
#   Example: puppet_agent_service: puppet
#
# [*puppet_agent_service_enable*]
#
# === Examples
#
#  class { '::puppet::agent::service': }
#
# === Authors
#
# Stefan Goethals <stefan.goethals@super-visions.com>
#
# === Copyright
#
# Copyright 2012 Super-Visions, unless otherwise noted.
#
class puppet::agent::service (
  $service    = 'puppet',
  $ensure     = true,
  $enable     = true,
  $hasstatus  = true,
  $hasrestart = true,
  $path       = undef,
  $restart    = undef,
  $start      = undef,
  $status     = undef,
  $stop       = undef,
) {
  service { $service:
    ensure     => $ensure,
    enable     => $enable,
    hasstatus  => $hasstatus,
    hasrestart => $hasrestart,
    path       => $path,
    restart    => $restart,
    start      => $start,
    status     => $status,
    stop       => $stop,
    subscribe  => Class['puppet::config'],
  }
}
