require 'puppet'
require 'fileutils'
require 'digest/md5'

class FixSsldir
  attr_accessor :new_ssldir

  def initialize
    @pup_vardir = Puppet[:vardir]
    @set_ssldir = Puppet[:ssldir]
    run
  end

  def run
    # return if the std ssldir is actually the one set & used
    return if isStdSsldirSet 
    # if std ssl dir does not exist, create by copy
    if ! findStdSsldir
      # copy existing to std
      copy
    else
      # if the stdssldir exists, compare the certificates
      if diffSslDirs
        # copy existing to std
        copy
      end
    end
    @new_ssldir = '$vardir/ssl'
  end

  private

  def copy
    FileUtils.rm_rf stdSsldir
    FileUtils.cp_r @set_ssldir, stdSsldir
    FileUtils.chown_R 'puppet', 'puppet', stdSsldir
    FileUtils.chown 'puppet', 'root', stdSsldir
  end

  def stdSsldir
    "#{@pup_vardir}#{File::SEPARATOR}ssl"
  end

  def findStdSsldir
    File.directory?( stdSsldir ) 
  end
  
  def findSetSsldir
    File.directory?( @set_ssldir )
  end

  def isStdSsldirSet
    @set_ssldir == stdSsldir
  end

  def certFileName
    Puppet[:certname] + '.pem'
  end

  # Calculate the md5 sum for current and std ssl cert
  # Return wether they are equal
  def diffSslDirs
    where = 'certs'
    where = 'private_keys'
    set_md5_sum = Digest::MD5.hexdigest( File.read( @set_ssldir + File::SEPARATOR + where + File::SEPARATOR + certFileName ) )
    std_md5_sum = Digest::MD5.hexdigest( File.read(  stdSsldir  + File::SEPARATOR + where + File::SEPARATOR + certFileName ) )
    set_md5_sum != std_md5_sum
  end
end

o = FixSsldir.new

Facter.add(:new_ssldir) do
  setcode do
    o.new_ssldir
  end
end

