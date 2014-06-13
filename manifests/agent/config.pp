
class puppet::agent::config inherits puppet::config
{

  #if $osfamily == 'RedHat' {
  if $osfamily == 'windows' {

    File['puppet.conf'] {
      content => template("puppet/agent/puppet.conf.windows.erb"),
    }

    realize File['puppet.conf']

  } elsif $osfamily == 'AIX' {
    File['puppet.conf'] {
      content => template("puppet/agent/puppet.conf.windows.erb"),
    }

    realize File['puppet.conf']

  } else {

    realize File['puppet.conf']

    if $puppet::config::server_fqdn == 'default' {
      $server_fqdn_action = 'rm'
    } else {
      $server_fqdn_action = 'set'
    }
    augeas {'agent.puppet.conf.main.server':
      context => "/files${puppet::config::confdir}/puppet.conf/main",
      changes => [ "${server_fqdn_action} server ${puppet::config::server_fqdn}", ],
      require => File['puppet.conf'],
      notify  => Class['puppet::agent::service'],
    }

    if $puppet::config::environment == 'default' {
      $environment_action = 'rm'
    } else {
      $environment_action = 'set'
    }
    augeas {'agent.puppet.conf.main.environment':
      context => "/files${puppet::config::confdir}/puppet.conf/main",
      changes => [ "$environment_action environment ${puppet::config::environment}", ],
      require => File['puppet.conf'],
      notify  => Class['puppet::agent::service'],
    }

    if $puppet::config::runinterval == 'default' {
      $runinterval_action = 'rm'
    } else {
      $runinterval_action = 'set'
    }
    augeas {'agent.puppet.conf.main.runinterval':
      context => "/files${puppet::config::confdir}/puppet.conf/main",
      changes => [ "${runinterval_action} runinterval ${puppet::config::runinterval}", ],
      require => File['puppet.conf'],
      notify  => Class['puppet::agent::service'],
    }

    if $puppet::config::log_level == 'default' {
      $log_level_action = 'rm'
    } else {
      $log_level_action = 'set'
    }
    augeas {'agent.puppet.conf.main.log_level':
      context => "/files${puppet::config::confdir}/puppet.conf/main",
      changes => [ "${log_level_action} log_level ${puppet::config::log_level}", ],
      require => File['puppet.conf'],
      notify  => Class['puppet::agent::service'],
    }

    if $puppet::config::logdir == 'default' {
      $logdir_action = 'rm'
    } else {
      $logdir_action = 'set'
    }
    augeas {'agent.puppet.conf.main.logdir':
      context => "/files${puppet::config::confdir}/puppet.conf/main",
      changes => [ "${logdir_action} logdir ${puppet::config::logdir}", ],
      require => File['puppet.conf'],
      notify  => Class['puppet::agent::service'],
    }

    if $puppet::config::vardir == 'default' {
      $vardir_action = 'rm'
    } else {
      $vardir_action = 'set'
    }
    augeas {'agent.puppet.conf.main.vardir':
      context => "/files${puppet::config::confdir}/puppet.conf/main",
      changes => [ "${vardir_action} vardir ${puppet::config::vardir}", ],
      require => File['puppet.conf'],
      notify  => Class['puppet::agent::service'],
    }

    if $puppet::config::real_ssldir {
      if $puppet::config::real_ssldir == 'default' {
        $ssldir_action = 'rm'
      } else {
        $ssldir_action = 'set'
      }
      augeas {'agent.puppet.conf.main.ssldir':
        context => "/files${puppet::config::confdir}/puppet.conf/main",
        changes => [ "${ssldir_action} ssldir ${puppet::config::real_ssldir}", ],
        require => File['puppet.conf'],
        notify  => Class['puppet::agent::service'],
      }
    }

    if $puppet::config::rundir == 'default' {
      $rundir_action = 'rm'
    } else {
      $rundir_action = 'set'
    }
    augeas {'agent.puppet.conf.main.rundir':
      context => "/files${puppet::config::confdir}/puppet.conf/main",
      changes => [ "${rundir_action} rundir ${puppet::config::rundir}", ],
      require => File['puppet.conf'],
      notify  => Class['puppet::agent::service'],
    }

    if $puppet::config::classfile == 'default' {
      $classfile_action = 'rm'
    } else {
      $classfile_action = 'set'
    }
    augeas {'agent.puppet.conf.agent.classfile':
      context => "/files${puppet::config::confdir}/puppet.conf/agent",
      changes => [ "${classfile_action} classfile ${puppet::config::classfile}", ],
      require => File['puppet.conf'],
      notify  => Class['puppet::agent::service'],
    }

    if $puppet::config::localconfig == 'default' {
      $localconfig_action = 'rm'
    } else {
      $localconfig_action = 'set'
    }
    augeas {'agent.puppet.conf.agent.localconfig':
      context => "/files${puppet::config::confdir}/puppet.conf/agent",
      changes => [ "${localconfig_action} localconfig ${puppet::config::localconfig}", ],
      require => File['puppet.conf'],
      notify  => Class['puppet::agent::service'],
    }

    augeas {'agent.puppet.conf.agent.report':
      context => "/files${puppet::config::confdir}/puppet.conf/agent",
      changes => [ "set report true", ],
      require => File['puppet.conf'],
      notify  => Class['puppet::agent::service'],
    }
  }
}
