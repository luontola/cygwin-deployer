# Copyright © 2012 Esko Luontola <www.orfjackal.net>
# This software is released under the Apache License 2.0.
# The license text is at http://www.apache.org/licenses/LICENSE-2.0

require_relative 'test_helpers'
require 'fileutils'

describe TemplateCopier do

  before(:all) do
    @sandbox = 'sandbox.tmp'
    @cygwin_home = dir('cygwin')
    @user_home = dir('user-home')
    @templates_dir = dir('templates')

    write(file(@templates_dir, 'global_file'), "global file")
    write(file(@templates_dir, 'home/user_file'), "user file")
    write(file(@templates_dir, '.hidden_file'), "hidden file")

    write(file(@templates_dir, 'unix_newlines'), "unix\nnewlines")
    write(file(@templates_dir, 'dos_newlines'), "dos\r\nnewlines")
    write(file(@templates_dir, 'include_variable'), "included: <%= @cygwin_home %>")

    write(file(@cygwin_home, 'etc/skel/.skeleton_file'), "original content")
    write(file(@templates_dir, 'home/.skeleton_file'), "<%= include('/etc/skel/.skeleton_file') %>\nuser customizations")

    write(file(@cygwin_home, 'file_to_include'), "file to include")
    write(file(@templates_dir, 'include_file'), "included: <%= include('/file_to_include') %>")

    tc = TemplateCopier.new(:cygwin_home => @cygwin_home,
                            :user_home => @user_home,
                            :username => 'johndoe',
                            :templates_dir => @templates_dir)
    tc.copy_all
  end

  after(:all) do
    FileUtils.rm_rf(@sandbox)
  end

  it "copies templates to Cygwin's install directory" do
    file(@cygwin_home, 'global_file').should be_a_file
  end

  it "copies templates under /home to user's home directory'" do
    file(@cygwin_home, 'home/user_file').should_not be_a_file
    file(@user_home, 'user_file').should be_a_file
  end

  it "copies also templates which are .hidden" do
    file(@cygwin_home, '.hidden_file').should be_a_file
  end

  it "copies /etc/skel into the user's home directory" do
    file(@user_home, '.skeleton_file').should be_a_file
  end

  it "allows customizing the files from /etc/skel" do # i.e. copying the skeleton is done before writing the templates
    IO.binread(file(@user_home, '.skeleton_file')).should == "original content\nuser customizations"
  end

  it "creates a symbolic link from /home/username to the user's real home directory" do
    symlink = file(@cygwin_home, 'home/johndoe')
    symlink.should be_a_file
    IO.binread(symlink).should include(@user_home.encode('UTF-16LE').force_encoding('US-ASCII'))
  end

  it "keeps Unix newlines in copied files" do
    IO.binread(file(@cygwin_home, 'unix_newlines')).should == "unix\nnewlines"
  end

  it "keeps DOS newlines in copied files" do
    IO.binread(file(@cygwin_home, 'dos_newlines')).should == "dos\r\nnewlines"
  end

  it "templates can insert Cygwin install directory" do
    IO.binread(file(@cygwin_home, 'include_variable')).should == "included: #{@cygwin_home}"
  end

  it "templates can insert contents a file from Cygwin install directory" do
    IO.binread(file(@cygwin_home, 'include_file')).should == "included: file to include"
  end


  # helpers

  def dir(name)
    dir = File.join(@sandbox, name)
    FileUtils.mkdir_p(dir)
    dir
  end

  def file(dir, name)
    File.join(dir, name)
  end

  def write(file, content)
    FileUtils.mkdir_p(File.dirname(file))
    File.open(file, 'wb') { |f| f.write(content) }
  end
end
