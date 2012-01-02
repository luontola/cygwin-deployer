require_relative 'test_helpers'
require 'fileutils'

describe Template do

  before(:each) do
    @install_dir = 'sandbox.tmp'
    Dir.mkdir(@install_dir)
    @templates_dir = '../templates'
    @templates_dir.should be_a_directory
    @template = Template.new(@install_dir, @templates_dir)
  end

  after(:each) do
    FileUtils.rm_rf(@install_dir)
  end

  it "copies Cygwin.bat with install dir configured" do
    target_file = "#{@install_dir}/Cygwin.bat"

    @template.copy("Cygwin.bat")

    target_file.should be_a_file
    content = IO.read(target_file)
    content.should include("chdir \"#{@install_dir}\\bin\"")
    content.should include("\r\n")
  end

  it "writes ~/.profile based on template which appends to /etc/skel/.profile" do
    pending("need to detect and populate home directory") # TODO

    skeleton = "#{@install_dir}/etc/skel/.profile"
    FileUtils.mkdir_p(File.dirname(skeleton))
    File.open(skeleton, 'w') do |file|
      file.puts("skeleton content")
    end

    @template.copy("~/.profile")

    target_file = "#{@install_dir}/home/username/.profile"
    target_file.should be_a_file
    content = IO.read(target_file)
    content.should include("skeleton content")
    content.should include("BASHHERE")
  end
end
