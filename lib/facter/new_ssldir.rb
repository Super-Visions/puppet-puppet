require 'puppet'
require 'fileutils'

class FixSsldir
  attr_accessor :new_ssldir

  def initialize
    @wanted_ssldir = 'ssl'
    @pup_user   = Puppet[:user]
    @pup_group  = Puppet[:group]
    @pup_vardir = Puppet[:vardir]
    @set_ssldir = Puppet[:ssldir]
    run
  end

  def run
    # return if the std ssldir is actually the one set & used
    return if isStdSsldirSet 
    # if std ssl dir is not set, create copy of current by force
    copy
    # Windows puppet config uses '/' as path separator
    @new_ssldir = '$vardir/' + @wanted_ssldir
  end

  private

  def copy
    FileUtils.rm_rf stdSsldir
    FileUtils.cp_r @set_ssldir, stdSsldir
    # all this causes problems on Windows and AIX
    #if Facter.value('kernel') != 'windows'
    #  FileUtils.chown_R @pup_user, @pup_group, stdSsldir
    #  FileUtils.chown @pup_user, @pup_group, stdSsldir
    #end
  end

  def stdSsldir
    @pup_vardir + File::SEPARATOR + @wanted_ssldir
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
end

o = FixSsldir.new

Facter.add(:new_ssldir) do
  setcode do
    o.new_ssldir
  end
end

