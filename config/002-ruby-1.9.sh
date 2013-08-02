#!/bin/sh
set -e

if [[ `ruby -v` == *1.9.3p448* ]]
then
    echo Already installed: `ruby -v`
    exit 0
fi


# Installing Ruby 1.9 from source
# http://www.curphey.com/2010/05/installing-and-configuring-ruby-1-9-from-source-using-cygwin/

FILENAME="ruby-1.9.3-p448"
wget http://ftp.ruby-lang.org/pub/ruby/1.9/$FILENAME.tar.bz2
tar xaf $FILENAME.tar.bz2
cd $FILENAME

./configure --prefix=/usr/local
make
make install

# verify installation
ruby -v
