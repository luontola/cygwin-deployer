@echo off

C:
chdir "<%= @cygwin_home %>\bin"

: Start in specified directory (http://sources.redhat.com/ml/cygwin/2002-05/msg01645.html)
: Modifications needed also in /etc/profile or ~/.profile or ~/.bash_profile
set BASH_HERE=%1

: Use Windows' profile directory instead of Cygwin's home
set HOME=%USERPROFILE%

: Other environmental variables
rem set LANG=en_US.UTF-8
set LANG=C.UTF-8

: Start the shell
rem bash --login -i
rem rxvt -sr -g 140x50 -sl 10000 -bg black -fg white -fn "Bitstream Vera Sans Mono" -fb "Bitstream Vera Sans Mono Bold" -e /usr/bin/bash --login -i
start mintty /usr/bin/bash --login -i
