#!/bin/sh
set -e

echo RubyGems `gem --version`
gem update --system
gem update


### Common gems ###
gem install rspec


### nanoc ###

gem install nanoc
gem install kramdown
gem install adsf


### Dependencies for Let's Code scripts ###
gem install imagesize
