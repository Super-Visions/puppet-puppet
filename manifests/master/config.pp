
class puppet::master::config inherits puppet::config
{
  File['puppet.conf'] {
    content => template("puppet/master/puppet.conf.erb"),
  }

  realize File['puppet.conf']
}
