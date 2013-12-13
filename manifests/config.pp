# config.pp

class puppet::config (
  $user          = 'root',
  $group         = 'root',
  $configdir     = $::puppet_confdir,
  $modulepath    = [ '/etc/puppet/modules' ],
  $server_fqdn   = 'UNDEFINED',
  $report_server = 'UNDEFINED',
  $autosign_file = '$confdir/autosign.conf',
  $agent_logdest = undef,
  $environment   = $::environment,
) {

  validate_array( $modulepath )

  @file { 'puppet.conf':
    ensure  => present,
    path    => "${configdir}/puppet.conf",
    content => template("puppet/agent/puppet.conf.erb"),
    owner   => $user,
    group   => $group,
    mode    => '0644',
  }
}
