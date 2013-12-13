require 'puppet'

Facter.add(:puppet_environment) do
  setcode do
    Puppet[:environment]
  end
end
