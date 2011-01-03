# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
if [ -f ~/dotfiles/env/.alias ]; then
  . ~/dotfiles/env/.alias
fi

BASH_ENV=$HOME/.bashrc
USERNAME=""
export USERNAME BASH_ENV
export VISUAL=vim
export EDITOR=vim
export RAILS_ENV=viewpointsdev
export DISPLAY=0:0


PATH=/usr/local/bin:$PATH
PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/bin/spidermonkey
PATH=$PATH:$HOME/bin/ruby
#PATH=$PATH:/Applications/MacVim-7_2-stable-1_2  
PATH=$PATH:/usr/local/mysql/bin
PATH=$PATH:/opt/firefox/
export PATH
unset USERNAME
PS1="\n$:"

#PS1="\n \n \h:\w  \n\247:"
PS1="\n \n\h:\w  \n> "
source ~/.git_completion

if [ "\$(type -t __git_ps1)" ]; then
  export PS1="\n \n\h:\w  \n\$(__git_ps1 '(%s) '): "
fi


# connecting to demo server.  first to gateway. egg01. then to demo: eghost10.dev.o.com

# perl global search and replace
# perl -i.bak -pe 's/<//g' `find . -name "*jsp"`
