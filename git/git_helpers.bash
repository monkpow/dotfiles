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

function gitClearOldBranches { 
  for k in $(git branch | sed /\*/d); do 
	if [ -n "$(git log -1 --since='4 weeks ago' -s $k)" ]; then
	  git branch -d $k
	fi
  done
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


function rebase_and_merge {
  BRANCH=$(parse_git_branch)
  gbout master && git co master && git pull origin master && git co $BRANCH && git rebase master && git co master &&  git merge $BRANCH
}




