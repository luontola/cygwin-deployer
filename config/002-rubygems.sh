#!/bin/sh
set -e

echo RubyGems `gem --version`
gem update --system


### Common gems ###
gem install rspec


### Jekyll ###

# Required to build posix-spawn
gem install rake-compiler

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
