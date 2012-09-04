# Get the aliases and functions

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

if [ -f ~/dotfiles/env/.alias ]; then
  . ~/dotfiles/env/.alias
fi

if [ -f .git_completion ]; then
   . .git_completion
fi

export VISUAL=vim
export EDITOR=vim
export TERM="xterm-color"


PS1="\n \n\h:\w  \n:"

if [ "\$(type -t __git_ps1)" ]; then
  export PS1="\n \n\h:\w  \n\$(__git_ps1 '(%s) '): "
fi

export NODE_PATH='/usr/local/lib/node_modules'
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

source ~/dotfiles/git/git_helpers.bash
