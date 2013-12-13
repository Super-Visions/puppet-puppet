require 'puppet'

Facter.add(:puppet_confdir) do
  setcode do
    Puppet[:confdir]
  end
end
