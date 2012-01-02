require 'net/http'
require 'fileutils'

def download(source_uri, target_file)
  puts "Downloading #{source_uri} to #{target_file}"
  source_uri = URI(source_uri)
  Net::HTTP.start(source_uri.host, source_uri.port) do |http|
    request = Net::HTTP::Get.new source_uri.request_uri

    http.request request do |response|
      print '['
      open target_file, 'wb' do |io|
        response.read_body do |chunk|
          print '.'
          io.write chunk
        end
      end
      puts ']'
    end
  end
end

def get_packages(file)
  packages = []
  IO::readlines(file).each do |line|
    package = line.split(';').first.strip
    packages << package unless package == ''
  end
  packages
end

def run(*command)
  system(*command) or raise "command failed: #{command.join(' ')}"
end
