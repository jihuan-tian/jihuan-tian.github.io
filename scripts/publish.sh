#!/bin/bash

is_need_commit=`git status | grep "nothing to commit, working tree clean"` 

if [ -z "$is_need_commit" ]; then
  echo "Commit the changes!"
  git add --all
  git commit -m `date +%F-%H-%M`
else
  echo "There is no changes!"
fi

git push
