require_relative 'utils'
require_relative 'template_copier'

APP_HOME = File.expand_path('..', File.dirname($0))

BIN_DIR = "#{APP_HOME}/bin"
CONFIG_DIR = "#{APP_HOME}/config"
TEMPLATES_DIR = "#{APP_HOME}/templates"
INSTALLER = "#{BIN_DIR}/setup.exe"
PACKAGES_LIST = "#{CONFIG_DIR}/packages.txt"

CYGWIN_HOME = "C:\\cygwin-tmp"
LOCAL_PACKAGE_DIR = "#{CYGWIN_HOME}\\setup"
DOWNLOAD_SITE = "ftp://ftp.sunet.se/pub/lang/cygwin/"
# TODO: find out the current customizations in %USERPROFILE% before overwriting them
#USER_HOME = ENV['HOME']
USER_HOME = "C:/cygwin-tmp/user-home-tmp"

download("http://cygwin.com/setup.exe", INSTALLER) unless File.exist? INSTALLER

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
                        :templates_dir => TEMPLATES_DIR)
tc.copy_all
