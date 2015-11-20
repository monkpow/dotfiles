# git functions
function local_branches() {
  git branch | grep -v master
}

function remote_branches() {
  git for-each-ref --format='%(committerdate) %09 %(authorname) %09 %(refname)' | grep -v -e '/release' -e '/hotfix' -e '/stable' -e '/master' | sort -k8 | grep remotes | grep "Krimm"
}

local_branches
remote_branches

