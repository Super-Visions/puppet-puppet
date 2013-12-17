# config.pp

class puppet::config (
  $user          = 'root',
  $group         = 'root',
  $confdir       = $::puppet_confdir,
  $vardir        = $::puppet_vardir,
  $modulepath    = [ '/etc/puppet/modules' ],
  $server_fqdn   = 'UNDEFINED',
  $report_server = 'UNDEFINED',
  $autosign_file = '$confdir/autosign.conf',
  $agent_logdest = undef,
  $environment   = $::environment,
) {

  validate_array( $modulepath )

  notify { "confdir:${confdir} - vardir:${vardir}": }

  @file { 'puppet.conf':
    ensure  => present,
    path    => "${confdir}/puppet.conf",
    content => template("puppet/agent/puppet.conf.erb"),
    owner   => $user,
    group   => $group,
    mode    => '0644',
  }
}
