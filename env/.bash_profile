# Get the aliases and functions

PATH="/usr/local/sbin:/usr/local/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"

export PATH

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

if [ -f ~/.profile ]; then
  . ~/.profile
fi

if [ -f ~/dotfiles/env/.alias ]; then
  . ~/dotfiles/env/.alias
fi

export VISUAL=vim
export EDITOR=vim
export TERM="xterm-color"

#PS1="\h:\W \u\$ "
PS1="\n[\u@\h] \W\n:"

# Source the git bash completion file
if [ -f ~/.git_completion ]; then
  source ~/.git_completion
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUPSTREAM="auto"
  PS1='\n\w\[\033[32m\]$(__git_ps1 "(%s)")\n\n'
fi

export CLICOLOR=1
export PS1

source ~/dotfiles/git/git_helpers.bash
source ~/dotfiles/rb/rb_post
source ~/dotfiles/git/log_branches.bash


node ~/dotfiles/shell/randAscii.js

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# use vim keybindings in node repl
#alias node="env NODE_NO_READLINE=1 rlwrap node"

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

# Key bindings, up/down arrow searches through history
#"\e[A": history-search-backward
#"\e[B": history-search-forward

# to change the location of the doc
# defaults write com.apple.dock pinning -string [start|middle|end]
# then, killall Dock to restart Dock

# make dock turn on real slow
# defaults write com.apple.dock autohide-delay -float 2; killall Dock
# undo
# defaults delete com.apple.dock autohide-delay; killall Dock


# to address NodeJS error “EMFILE, too many open files” on Mac OS on TMS
# http://stackoverflow.com/questions/19981065/nodejs-error-emfile-too-many-open-files-on-mac-os
#ulimit -n 65536
#ulimit -u 2048

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
