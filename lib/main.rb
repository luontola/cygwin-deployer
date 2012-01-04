# Copyright © 2012 Esko Luontola <www.orfjackal.net>
# This software is released under the Apache License 2.0.
# The license text is at http://www.apache.org/licenses/LICENSE-2.0

require_relative 'utils'
require_relative 'template_copier'

CWD = File.expand_path('..', File.dirname($0))
BIN_DIR = "#{CWD}/bin"
CONFIG_DIR = "#{CWD}/config"
TEMPLATES_DIR = "#{CWD}/templates"

INSTALLER = "#{BIN_DIR}/setup.exe"
PACKAGES_LIST = "#{CONFIG_DIR}/packages.txt"
PATHS_CONFIG = "#{CONFIG_DIR}/paths.rb"

def get_path(key)
  paths = eval(IO.read(PATHS_CONFIG))
  paths[key] or raise "#{key} not found"
end

CYGWIN_HOME = get_path(:CYGWIN_HOME)
USER_HOME = get_path(:USER_HOME)
USERNAME = get_path(:USERNAME)
DOWNLOAD_SITE = get_path(:DOWNLOAD_SITE)
LOCAL_PACKAGE_DIR = "#{CYGWIN_HOME}\\setup"

download("http://cygwin.com/setup.exe", INSTALLER) unless recently_modified? INSTALLER

packages = get_packages(PACKAGES_LIST)
puts "Installing packages: #{packages.join(' ')}"
run(INSTALLER,
    '--quiet-mode',
    '--download',
    '--local-install',
    '--site', DOWNLOAD_SITE,
    '--root', CYGWIN_HOME,
    '--local-package-dir', LOCAL_PACKAGE_DIR,
    '--packages', packages.join(','),
    '--no-shortcuts',
    '--no-startmenu',
    '--no-desktop',
    '--disable-buggy-antivirus',
)

tc = TemplateCopier.new(:cygwin_home => CYGWIN_HOME,
                        :user_home => USER_HOME,
                        :username => USERNAME,
                        :templates_dir => TEMPLATES_DIR)
tc.copy_all

puts
puts "Creating 'Open Bash Here' context menu"
run('reg', 'import', File.join(CYGWIN_HOME, 'OpenBashHere.reg'))
