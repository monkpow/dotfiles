# Get the aliases and functions

PATH="/System/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
PATH="/usr/local/bin":"/usr/local/Cellar/vim/7.3.875/bin/":${PATH}
PATH="~/dev/brighttag/pypr/jira/jira_client/":${PATH}
PATH="~/dotfiles/clojure/lein":${PATH}

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
  PS1='\n\w\[\033[32m\]$(__git_ps1 "(%s)")\n> '
fi

export CLICOLOR=1
export PS1

source ~/dotfiles/git/git_helpers.bash
source ~/dotfiles/rb/rb_post
source ~/dotfiles/shell/randAscii.sh



[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# use vim keybindings in node repl
alias node="env NODE_NO_READLINE=1 rlwrap node"

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH
