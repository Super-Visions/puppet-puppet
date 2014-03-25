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

  def test
    FileUtils.rm_rf testDir
    FileUtils.cp_r @set_ssldir, testDir 
  end

  def testDir
    'c:/tmp/test'
  end

  def copy
    puts "rm_f stdSsldir:#{stdSsldir}"
    FileUtils.rm_rf stdSsldir
    puts "cp_r set_ssldir:#{@set_ssldir}:, stdSsldir:#{stdSsldir}:"
    FileUtils.cp_r @set_ssldir, stdSsldir
    if Facter.value('kernel') != 'windows'
      FileUtils.chown_R @pup_user, @pup_group, stdSsldir
      FileUtils.chown @pup_user, @pup_group, stdSsldir
    end
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

