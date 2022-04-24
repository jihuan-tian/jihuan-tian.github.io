#!/bin/bash

is_need_commit=`git status | grep "nothing to commit, working tree clean"` 

if [ -z "$is_need_commit" ]; then
  echo "=== Commit the changes!"
  git add --all
  git commit -m `date +%F-%H-%M`
else
  echo "=== There are no changes to commit!"
fi

is_need_push=`git status | grep "Your branch is up to date with 'origin/main'."`
if [ -z "$is_need_push" ]; then
  echo "=== Start to push to remote branch!"
  git push
else
  echo "There is nothing to push!"
fi
