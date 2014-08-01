#!/bin/sh
set -e

echo RubyGems `gem --version`
#gem update --system
# XXX: RubyGems 2.3.0-2.4.1 don't work on Cygwin; they fail with "can't convert nil into String"
gem update --system 2.2.2
gem update

### Common gems ###
gem install rspec
gem install bundler

### nanoc ###
gem install nanoc
gem install kramdown
gem install adsf

### Dependencies for Let's Code scripts ###
gem install imagesize
