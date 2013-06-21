# Get the aliases and functions

export PATH="/usr/local/bin":"/usr/local/Cellar/vim/7.3.875/bin/":$PATH

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

if [ -f ~/dotfiles/env/.alias ]; then
  . ~/dotfiles/env/.alias
fi

export VISUAL=vim
export EDITOR=vim
export TERM="xterm-color"

#PS1="\h:\W \u\$ "
PS1="\n\u@\h \W\n> "

# Source the git bash completion file
if [ -f ~/.git_completion ]; then
  source ~/.git_completion
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUPSTREAM="auto"
  PS1='\n\W:\[\033[32m\]$(__git_ps1 "(%s)")\n> '
fi

export PS1


#export NODE_PATH='/usr/local/lib/node_modules'
#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"

#source ~/dotfiles/git/git_helpers.bash

export SAUCE_USERNAME=radio_chris
export SAUCE_ACCESS_KEY=05000672-8027-4869-a5ce-da1a6dde3d33
