require_relative 'test_helpers'
require 'fileutils'


describe "download" do

  before(:each) do
    @output_file = 'download.tmp'
  end

  after(:each) do
    FileUtils.rm_f(@output_file)
  end

  it "downloads the file" do
    download('http://www.google.com/', @output_file)
    @output_file.should be_a_file
    IO.read(@output_file).should include("text/html")
  end
end


describe "get_packages" do

  before(:each) do
    @packages_file = 'packages.tmp'
  end

  after(:each) do
    FileUtils.rm_f(@packages_file)
  end

  it "lists all package names in the file" do
    File.open(@packages_file, 'w') do |file|
      file.puts "pkg1"
      file.puts "pkg2"
    end

    get_packages(@packages_file).should == ["pkg1", "pkg2"]
  end

  it "ignores comment lines" do
    File.open(@packages_file, 'w') do |file|
      file.puts "pkg1"
      file.puts "; comment line"
      file.puts "pkg2"
    end

    get_packages(@packages_file).should == ["pkg1", "pkg2"]
  end

  it "ignores trailing comments" do
    File.open(@packages_file, 'w') do |file|
      file.puts "pkg1 ; trailing comment"
      file.puts "pkg2"
    end

    get_packages(@packages_file).should == ["pkg1", "pkg2"]
  end
end
