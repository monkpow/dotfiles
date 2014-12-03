#!/bin/bash

$(git fetch --prune)

for branch in $(git branch -r); do
  if ([ "$branch" == "origin/HEAD" ] || [ "$branch" == "origin/master" ] || [ "$branch" == "->" ]); then
    continue
  fi
  printf "$(git log $branch -n1 --pretty=format:"%ad $branch %an" --date=short)\n";
done | sort
