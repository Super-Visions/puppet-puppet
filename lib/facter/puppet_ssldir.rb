require 'puppet'

Facter.add(:puppet_ssldir) do
  setcode do
    Puppet[:ssldir]
  end
end

