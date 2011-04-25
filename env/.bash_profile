# Get the aliases and functions

if [ -f ~/dotfiles/env/.alias ]; then
  . ~/dotfiles/env/.alias
fi

export VISUAL=vim
export EDITOR=vim
#export DISPLAY=0:0

PATH=/usr/local/bin:$PATH
PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/bin/spidermonkey
PATH=$PATH:$HOME/bin/ruby
PATH=$PATH:/usr/local/mysql/bin
PATH=$PATH:/opt/firefox/
export PATH
PS1="\n \n\h:\w  \n:"
#PS1="\n\n\h:\w  \n\245"



if [ "\$(type -t __git_ps1)" ]; then
  export PS1="\n \n\h:\w  \n\$(__git_ps1 '(%s) '): "
fi

