# git functions
function local_branches() {
  git branch | grep -v master
}

function remote_branches() {
  git for-each-ref --format='%(tag) %09 %(refname)' | grep -v -e '/release' -e '/hotfix' -e '/stable' -e '/master' | sort -k8 | grep remotes | grep "Krimm"
}

function recent_branches() {
  git for-each-ref --format='%(committerdate) %09 %(authorname) %09 %(refname)' | grep -v -e '/release' -e '/hotfix' -e '/stable' -e '/master' | sort -k8 | grep remotes | grep "Krimm"
alias log_branches="for x in "`recent_branches`"; do echo 1; done | head -n20"
}

if [ -d .git ]; then 
  local_branches
  remote_branches
fi

