<%= include('/etc/skel/.bashrc') %>

[[ -f /etc/bash_completion ]] && . /etc/bash_completion

alias ls='ls --color=auto'

export EDITOR="nano"
export CYGWIN="nodosfilewarning"

# Fix for Jekyll on Cygwin
# http://nathanielstory.com/2013/12/28/jekyll-on-windows-with-cygwin.html
# https://github.com/jekyll/jekyll/issues/1383
export COMSPEC=/cygdrive/c/Windows/System32/cmd.exe

# See http://code.google.com/p/mintty/wiki/Tips#Changing_colours
echo -ne '\e]4;0;#000000\a'   # black
echo -ne '\e]4;1;#BF0000\a'   # red
echo -ne '\e]4;2;#00BF00\a'   # green
echo -ne '\e]4;3;#BFBF00\a'   # yellow
#echo -ne '\e]4;4;#0000BF\a'   # blue
echo -ne '\e]4;4;#4040FF\a'   # blue (light; same as bold blue)
echo -ne '\e]4;5;#BF00BF\a'   # magenta
echo -ne '\e]4;6;#00BFBF\a'   # cyan
echo -ne '\e]4;7;#BFBFBF\a'   # white (light grey really)
echo -ne '\e]4;8;#404040\a'   # bold black (i.e. dark grey)
echo -ne '\e]4;9;#FF4040\a'   # bold red
echo -ne '\e]4;10;#40FF40\a'  # bold green
echo -ne '\e]4;11;#FFFF40\a'  # bold yellow
echo -ne '\e]4;12;#4040FF\a'  # bold blue
echo -ne '\e]4;13;#FF40FF\a'  # bold magenta
echo -ne '\e]4;14;#40FFFF\a'  # bold cyan
echo -ne '\e]4;15;#FFFFFF\a'  # bold white
