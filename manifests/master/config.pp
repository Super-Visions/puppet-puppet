
class puppet::master::config inherits puppet::config
{
  #File['puppet.conf'] {
  #  content => template("puppet/master/puppet.conf.erb"),
  #}

  #realize File['puppet.conf']

  if $puppet::config::server_fqdn == 'default' {
    $server_fqdn_action = 'rm'
  } else {
    $server_fqdn_action = 'set'
  }
  augeas {'master.puppet.conf.main.server':
    context => "/files${puppet::config::confdir}/puppet.conf/main",
    changes => [ "${server_fqdn_action} server ${puppet::config::server_fqdn}", ],
    require => File['puppet.conf'],
    notify  => Class['puppet::master::service'],
  } 

  if $puppet::config::environment == 'default' {
    $environment_action = 'rm'
  } else {
    $environment_action = 'set'
  }
  augeas {'master.puppet.conf.main.environment':
    context => "/files${puppet::config::confdir}/puppet.conf/main",
    changes => [ "$environment_action environment ${puppet::config::environment}", ],
    require => File['puppet.conf'],
    notify  => Class['puppet::master::service'],
  } 

  if $puppet::config::logdir == 'default' {
    $logdir_action = 'rm'
  } else {
    $logdir_action = 'set'
  }
  augeas {'master.puppet.conf.main.logdir':
    context => "/files${puppet::config::confdir}/puppet.conf/main",
    changes => [ "${logdir_action} logdir ${puppet::config::logdir}", ],
    require => File['puppet.conf'],
    notify  => Class['puppet::master::service'],
  } 

  if $puppet::config::vardir {
    if $puppet::config::vardir == 'default' {
      $vardir_action = 'rm'
    } else {
      $vardir_action = 'set'
    }
    augeas {'master.puppet.conf.main.vardir':
      context => "/files${puppet::config::confdir}/puppet.conf/main",
      changes => [ "${rundir_action} vardir ${puppet::config::vardir}", ],
      require => File['puppet.conf'],
      notify  => Class['puppet::master::service'],
    } 
  }

  if $puppet::config::ssldir {
    if $puppet::config::ssldir == 'default' {
      $ssldir_action = 'rm'
    } else {
      $ssldir_action = 'set'
    }
    augeas {'master.puppet.conf.main.ssldir':
      context => "/files${puppet::config::confdir}/puppet.conf/main",
      changes => [ "${ssldir_action} ssldir ${puppet::config::ssldir}", ],
      require => File['puppet.conf'],
      notify  => Class['puppet::master::service'],
    } 
  }

  if $puppet::config::rundir == 'default' {
    $rundir_action = 'rm'
  } else {
    $rundir_action = 'set'
  }
  augeas {'master.puppet.conf.main.rundir':
    context => "/files${puppet::config::confdir}/puppet.conf/main",
    changes => [ "${rundir_action} rundir ${puppet::config::rundir}", ],
    require => File['puppet.conf'],
    notify  => Class['puppet::master::service'],
  } 

  if $puppet::config::modulepath {
    if $puppet::config::modulepath == 'default' {
      $modulepath_action = 'rm'
      $modulepath = ''
    } else {
      $modulepath_action = 'set'
      $modulepath =  join($puppet::config::modulepath, ":")
    }
    augeas {'master.puppet.conf.main.modulepath':
      context => "/files${puppet::config::confdir}/puppet.conf/main",
      changes => [ "${modulepath_action} modulepath ${modulepath}", ],
      require => File['puppet.conf'],
      notify  => Class['puppet::master::service'],
    } 
  }
  
  if $puppet::config::autosign_file {
    if $puppet::config::autosign_file == 'default' {
      $autosign_file_action = 'rm'
    } else {
      $autosign_file_action = 'set'
    }
    augeas {'master.puppet.conf.master.autosign_file':
      context => "/files${puppet::config::confdir}/puppet.conf/master",
      changes => [ "${rundir_action} autosign ${puppet::config::autosign_file}", ],
      require => File['puppet.conf'],
      notify  => Class['puppet::master::service'],
    } 
  }

  if $puppet::config::reports == 'default' {
    $reports_action = 'rm'
  } else {
    $reports_action = 'set'
  }
  augeas {'master.puppet.conf.master.reports':
    context => "/files${puppet::config::confdir}/puppet.conf/master",
    changes => [ "${rundir_action} reports ${puppet::config::reports}", ],
    require => File['puppet.conf'],
    notify  => Class['puppet::master::service'],
  } 

}
