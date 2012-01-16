#!/bin/sh
set -e

if [[ `ruby -v` == *1.9.3p0* ]]
then
    echo Already installed: `ruby -v`
    exit 0
fi


# Installing libyaml to avoid warnings from `gem`
# http://collectiveidea.com/blog/archives/2011/10/31/install-ruby-193-with-libyaml-on-centos/

FILENAME="yaml-0.1.4"
wget http://pyyaml.org/download/libyaml/$FILENAME.tar.gz
tar xaf $FILENAME.tar.gz
cd $FILENAME

./configure --prefix=/usr/local
make
make install


# Installing Ruby 1.9 from source
# http://www.curphey.com/2010/05/installing-and-configuring-ruby-1-9-from-source-using-cygwin/

FILENAME="ruby-1.9.3-p0"
wget http://ftp.ruby-lang.org/pub/ruby/1.9/$FILENAME.tar.bz2
tar xaf $FILENAME.tar.bz2
cd $FILENAME

# FIXME: doesn't compile with libyaml, resulting in warnings when using gem
./configure --prefix=/usr/local --with-opt-dir=/usr/local/lib
make
make install

# verify installation
ruby -v
