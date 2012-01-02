@echo off

C:
chdir "<%= @cygwin_home %>\bin"

: Start in specified directory (http://sources.redhat.com/ml/cygwin/2002-05/msg01645.html)
: Modifications needed also in \cygwin\etc\profile
set BASHHERE=%1
set LANG=en_US.UTF-8
rem bash --login -i
rem rxvt -sr -g 140x50 -sl 10000 -bg black -fg white -fn "Bitstream Vera Sans Mono" -fb "Bitstream Vera Sans Mono Bold" -e /usr/bin/bash --login -i
start mintty /usr/bin/bash --login -i
