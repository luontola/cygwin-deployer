#!/bin/sh
set -e

# Change the home directories to be the same as Windows uses.
# This fixes ssh which uses the home from /etc/passwd and not $HOME.
# See http://cygwin.com/faq/faq-nochunks.html#faq.setup.home
mkpasswd -l -c -p "$(cygpath -H)" > /etc/passwd
