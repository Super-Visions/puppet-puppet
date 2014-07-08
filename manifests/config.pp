# config.pp

class puppet::config (
  $user                = 'root',
  $group               = 'root',
  $mode                = '0644',
  $confdir             = $::puppet_confdir,
  $modulepath          = [ '/etc/puppet/modules' ],
  $server_fqdn         = 'default',
  $autosign_file       = '$confdir/autosign.conf',
  $agent_logdest       = undef,
  $environment         = $::environment,
  $ssldir              = '$vardir/ssl',
  $vardir              = 'default',
  $logdir              = '/var/log/puppet',
  $rundir              = '/var/run/puppet',
  $classfile           = '$vardir/classes.txt',
  $localconfig         = '$vardir/localconfig',
  $report              = 'true',
  $reports             = 'store',
  $parser              = 'default',
  $use_new_ssldir_fact = false,
  $environmentpath     = undef,
  $log_level           = 'default',
  $runinterval         = 'default',
  $certname            = 'default',
) {

  # Code for fixing ssldir
  if $use_new_ssldir_fact {
    #notify { "Using new_ssldir_fact ${::new_ssldir}": }
    $real_ssldir = $::new_ssldir
  } else {
    $real_ssldir = $ssldir
  }
  #notify { "\nssldir:${ssldir}\npuppet_ssldir:${::puppet_ssldir}\nnew_ssldir:${::new_ssldir}\nreal_ssldir:${real_ssldir}\n": }
  #
  # if the code above is ever removed, uncomment the next line (var used in augeas and templates)
  # $real_ssldir = $ssldir
  #

  @file { 'puppet.conf':
    ensure  => present,
    path    => "${confdir}/puppet.conf",
    mode    => $mode,
  #  content => template("puppet/agent/puppet.conf.erb"),
  #  owner   => $user,
  #  group   => $group,
  }


}
