#
# == Class: puppet::agent::package
#
# The puppet::agent::package class manages the 
# puppet agent package resource
#
# === Parameters
#
# This class does not take parameters as all parameters are fetched via hiera
# The parameter defaults are stored in the puppet::data class
#
# === Variables
#
# [*package_name*]
#   the package name is fetched from puppet::data via
#   the puppet_backend for Hiera. It can be overridden by 
#   specyfying a different value in an applicable hiera file.
#   Example: puppet_agent_package: puppet-agent
#
# === Examples
#
#  class { '::puppet::agent::package': }
#
# === Authors
#
# Stefan Goethals <stefan.goethals@super-visions.com>
#
# === Copyright
#
# Copyright 2012 Super-Visions, unless otherwise noted.
#
class puppet::agent::package (
  $package = 'puppet',
  $ensure = 'installed',
) {

  package { $package:
    ensure => $ensure,
  }
}
