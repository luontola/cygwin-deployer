#!/bin/sh
set -e

echo RubyGems `gem --version`
gem update --system
gem update

### Common gems ###
gem install rdoc
gem install rspec
gem install bundler

### nanoc ###
gem install nanoc
gem install kramdown
gem install adsf

### Dependencies for Let's Code scripts ###
gem install imagesize
