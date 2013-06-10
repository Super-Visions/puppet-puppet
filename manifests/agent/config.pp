
class puppet::agent::config inherits puppet::config
{
  realize File['puppet.conf']
}
