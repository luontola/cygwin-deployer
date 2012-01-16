#!/bin/sh
set -e

gem update --system
echo Using RubyGems `gem --version`


# http://cinderwick.ca/blog/2011/04/install-jekyll-and-pygments-under-windows-with-cygwin/
#FILENAME="rubygems-1.8.15"
#wget http://rubyforge.org/frs/download.php/75711/$FILENAME.tgz
#tar xaf $FILENAME.tgz
#cd $FILENAME
#ruby setup.rb install


gem install rspec


# Jekyll depends on posix-spawn, but the current release cannot be built on Cygwin.
# There is a fix for posix-spawn, but it's not yet released, so we must build it ourselves.
# https://github.com/rtomayko/posix-spawn/issues/21
# http://fossplanet.com/f14/ruby-1-9-3-p0-cygwin-1-7-9-1-posix-spawn-0-3-6-cant-setruby_platform-%3D-cygwin-210927/#post643795
git clone http://github.com/rtomayko/posix-spawn.git
cd posix-spawn
git checkout --quiet 593ec5386775f60cf131aad060244613de0cbed7
rake gem
gem install pkg/posix-spawn-0.3.6.gem
cd ..

gem install jekyll
