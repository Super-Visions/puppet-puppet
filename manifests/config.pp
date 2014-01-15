# config.pp

class puppet::config (
  $user          = 'root',
  $group         = 'root',
  $mode          = '0644',
  $confdir       = $::puppet_confdir,
  $modulepath    = [ '/etc/puppet/modules' ],
  $server_fqdn   = undef,
  $autosign_file = '$confdir/autosign.conf',
  $agent_logdest = undef,
  $environment   = $::environment,
  $ssldir        = '$vardir/ssl',
  $vardir        = 'default',
  $logdir        = '/var/log/puppet',
  $rundir        = '/var/run/puppet',
  $classfile     = '$vardir/classes.txt',
  $localconfig   = '$vardir/localconfig',
  $report        = 'true',
  $reports       = 'store',
  $parser        = 'default',
) {

  #validate_array( $modulepath )

  #notify { "confdir:${confdir} - vardir:${vardir}": }

  @file { 'puppet.conf':
    ensure  => present,
    path    => "${confdir}/puppet.conf",
    mode    => $mode,
  #  content => template("puppet/agent/puppet.conf.erb"),
  #  owner   => $user,
  #  group   => $group,
  }


}
