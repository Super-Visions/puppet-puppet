#
# == Class: puppet::agent
#
# The puppet::agent class manages the dependency of the classes
# to apply to configure a puppet agent
#
# === Parameters
#
# This class does not take parameters as all parameters are fetched via hiera
# The parameter defaults are stored in the puppet::data class
#
# === Variables
#
# No variables are used in this class
#
# === Examples
#
#  class { '::puppet::agent': }
#
# === Authors
#
# Stefan Goethals <stefan.goethals@super-visions.com>
#
# === Copyright
#
# Copyright 2012 Super-Visions, unless otherwise noted.
#
class puppet::agent
{
  anchor { 'puppet::agent::start': }->
  #class { 'puppet::agent::package': }->
  class { 'puppet::agent::cron': }->
  class { 'puppet::agent::config': }->
  class { 'puppet::agent::service': }->
  anchor { 'puppet::agent::end': }

  stage { 'puppetupgrade': require => Stage['main'] }
  class { 'puppet::agent::package': stage => 'puppetupgrade' }
}
