require_relative 'utils'

APP_HOME = File.expand_path('..', File.dirname($0))

BIN_DIR = "#{APP_HOME}/bin"
CONFIG_DIR = "#{APP_HOME}/config"
INSTALLER = "#{BIN_DIR}/setup.exe"
PACKAGES_LIST = "#{CONFIG_DIR}/packages.txt"

INSTALL_DIR = "C:\\cygwin-tmp"
LOCAL_PACKAGE_DIR = "#{INSTALL_DIR}\\setup"

download("http://cygwin.com/setup.exe", INSTALLER) unless File.exist? INSTALLER

packages = get_packages(PACKAGES_LIST)
puts "Installing packages: #{packages.join(' ')}"
run(INSTALLER,
    '--quiet-mode',
    '--download',
    '--local-install',
    '--root', INSTALL_DIR,
    '--local-package-dir', LOCAL_PACKAGE_DIR,
    '--packages', packages.join(','),
    '--no-shortcuts',
    '--no-startmenu',
    '--no-desktop',
    '--disable-buggy-antivirus',
)
