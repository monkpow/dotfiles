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

PS1="\n \n\h:\w  \n:"

if [ "\$(type -t __git_ps1)" ]; then
  export PS1="\n \n\h:\w  \n\$(__git_ps1 '(%s) '): "
fi


# perl global search and replace
# perl -i.bak -pe 's/<//g' `find . -name "*jsp"`
export CLICOLOR=1
export LSCOLORS=exFxCxDxBxegedabagacad

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
#PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
#PATH="/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages/django/bin:${PATH}"
#PATH="/opt/local/bin:${PATH}"
#export PATH

##
# Your previous /Users/nkrimm/.bash_profile file was backed up as /Users/nkrimm/.bash_profile.macports-saved_2011-05-09_at_14:35:54
##

# MacPorts Installer addition on 2011-05-09_at_14:35:54: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

# for selenium/capybara test runner
export capybara_app_host='dashboard.nextagqa.com:3000'


# git functions
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function gbin {
    COMMITS=$(git log ..$1 --no-merges --format='%h | %an | %ad | %s' --date=local)
    if [ -n "$COMMITS" ]; then
        echo branch \($1\) has these commits and \($(parse_git_branch)\) does not
        echo "$COMMITS"
        echo
    fi
}

function gbout {
    COMMITS=$(git log $1.. --no-merges --format='%h | %an | %ad | %s' --date=local)
    if [ -n "$COMMITS" ]; then
        echo branch \($(parse_git_branch)\) has these commits and \($1\) does not
        echo "$COMMITS"
        echo
    fi
}


function git-list-old-merged-branches {
    # never allow the master branch to show up here
    COMMITS=$(git branch -a --merged|grep -v "master$"|grep -v "\->"|sed s/^..//)
    for k in $COMMITS;do
        echo -e $(git log -1 --pretty=format:"%Cgreen%ci %Cred%cr%Creset" "$k")\\t"$k";
    done | sort
}



# convenience function for gerrit code reviews
postgreview ()
{
   if [ -z "$1" -o -z "$2" ]; then
       echo "usage: postgreview <repository> <branch>"
   else
       echo "submitting review for branch $2 in repo $1"
       git push ssh://dev-git1.corp.nextag.com:29418/$1 HEAD:refs/for/$2;
   fi
}

# Setting PATH for JRuby 1.6.7
# The orginal version is saved in .bash_profile.jrubysave
PATH="${PATH}:/Library/Frameworks/JRuby.framework/Versions/Current/bin"
export PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


export JAVA_HOME=/Library/Java/Home
export CATALINA_HOME=/Library/Tomcat/Home
