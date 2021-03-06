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
  $manage      = true,
  $package     = 'puppet',
  $ensure      = 'installed',
  $tmp_dir     = undef,
  $remote_url  = undef,
  $remote_file = undef,
  $source      = undef,
  $provider    = undef,
  $checkver    = false,
  $ensurever   = undef,
) {

  if $checkver {
    if ! $ensurever {
      fail( 'Puppet agent version checking requested (checkver => true) but no "ensurever" (required version) param provided' )
    }
    if versioncmp( $::puppetversion, $ensurever ) >= 0 {
      $update = false
      #notify { "1 - update = false : '${::puppetversion}', '${ensurever}'": }
    } else {
      $update = true
      #notify { "2 - update = true : '${::puppetversion}', '${ensurever}'": }
    }
  } else {
    $update = true
    #notify { "3 - no check : '${::puppetversion}', '${ensurever}'": }
  }


  if $manage and $update {

    if $remote_file {
      file{ $tmp_dir:
        ensure  => directory,
        recurse => true,
      }

      if $::kernel == 'windows' {
    	  pget{'DownloadPuppet':
    	    source  => "${remote_url}/${remote_file}",
          target  => $tmp_dir,
          require => File[$tmp_dir]
        }
        $require = Pget['DownloadPuppet']
      } else {
        file{ '/var/cache/wget':
          ensure  => directory,
          recurse => true,
        }
        wget::fetch { "${remote_url}/${remote_file}":
          destination => "${tmp_dir}/${remote_file}",
          cache_dir   => '/var/cache/wget',
          require     => [File[$tmp_dir],File['/var/cache/wget']],
        }
        $require = Wget::Fetch["${remote_url}/${remote_file}"]
      }
    } else {
      $require  = undef
    }

    if $::kernel == 'windows' {
      $install_options = ['/qn']
    } else {
      $install_options = undef
    }

    package { $package:
      ensure   => $ensure,
      provider => $provider,
      require  => $require,
      source   => $source,
      install_options => $install_options,
    }
  }
}
