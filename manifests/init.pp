#
# == Class: puppet
#
# The puppet class includes the management of a puppet agent
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
#  class { '::puppet': }
#
# === Authors
#
# Stefan Goethals <stefan.goethals@super-visions.com>
#
# === Copyright
#
# Copyright 2012 Super-Visions, unless otherwise noted.
#
class puppet
{
  anchor { 'puppet::start': }->
  class  { 'puppet::agent': }->
  anchor { 'puppet::end': }
}
