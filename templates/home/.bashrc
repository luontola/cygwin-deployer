<%= include('/etc/skel/.bashrc') %>

[[ -f /etc/bash_completion ]] && . /etc/bash_completion

alias ls='ls --color=auto'

export EDITOR="nano"
export CYGWIN="nodosfilewarning"
