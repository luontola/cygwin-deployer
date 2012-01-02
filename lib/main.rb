require_relative 'utils'

APP_HOME = File.expand_path('..', File.dirname($0))

BIN_DIR = "#{APP_HOME}/bin"
CONFIG_DIR = "#{APP_HOME}/config"
INSTALLER = "#{BIN_DIR}/setup.exe"
PACKAGES_LIST = "#{CONFIG_DIR}/packages.txt"

download("http://cygwin.com/setup.exe", INSTALLER) unless File.exist? INSTALLER

packages = get_packages(PACKAGES_LIST)
puts "Installing packages: #{packages.join(' ')}"
