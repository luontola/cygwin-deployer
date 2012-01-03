require_relative 'utils'
require_relative 'template'

APP_HOME = File.expand_path('..', File.dirname($0))

BIN_DIR = "#{APP_HOME}/bin"
CONFIG_DIR = "#{APP_HOME}/config"
TEMPLATES_DIR = "#{APP_HOME}/templates"
INSTALLER = "#{BIN_DIR}/setup.exe"
PACKAGES_LIST = "#{CONFIG_DIR}/packages.txt"

CYGWIN_HOME = "C:\\cygwin-tmp"
LOCAL_PACKAGE_DIR = "#{CYGWIN_HOME}\\setup"
DOWNLOAD_SITE = "ftp://ftp.sunet.se/pub/lang/cygwin/"

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

template = Template.new(CYGWIN_HOME, TEMPLATES_DIR)
template.copy("Cygwin.bat")

# TODO: copy /etc/skel/* to %USERPROFILE% and add customizations from templates

# FIXME: duplicates the contents when run multiple times
# TODO: write ~/.profile based on /etc/skel/.profile and a template
#template.copy("etc/profile")
