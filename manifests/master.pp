
class puppet::master
{
  anchor { 'puppet::master::start': }->
  class { 'puppet::master::package': }->
  class { 'puppet::master::config': }->
  class { 'puppet::master::service': }->
  anchor { 'puppet::master::end': }
}
