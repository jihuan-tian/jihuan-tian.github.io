#!/bin/bash

is_need_commit=`git status | grep "nothing to commit, working tree clean"` 
echo $is_need_commit
if [ -z "$is_need_commit" ]; then
  echo "There is no change, now exit!"
else
  git add --all
  git commit -m `date +%F-%H-%M`
fi

is_need_push=``
