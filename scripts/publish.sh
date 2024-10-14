#!/bin/bash

cd "$blog"

is_need_commit=`git status | grep "nothing to commit, working tree clean"` 

if [ -z "$is_need_commit" ]; then
  echo "=== Commit the changes!"
  git add --all

  # Remove _config.yml from the commit, since it is modified for local build.
  git restore --staged _config.yml

  if  [ "$#" -eq 1 ]; then
    # When there is a command line argument, use it as the committing message.
    git commit -m `date +%F-%H-%M`": $1"
  else
    git commit -m `date +%F-%H-%M`
  fi
else
  echo "=== There are no changes to commit!"
fi

is_need_push=`git status | grep "Your branch is up to date with 'origin/main'."`
if [ -z "$is_need_push" ]; then
  echo "=== Start to push source to remote branch!"
  http_proxy=192.168.0.100:1080 https_proxy=192.168.0.100:1080 git push

  # Go to the public folder and pull the latest modifications.
  sleep 5
  cd "$blog-public"
  http_proxy=192.168.0.100:1080 https_proxy=192.168.0.100:1080 git pull
  
  # Build for public.
  bundle exec jekyll build --destination "$blog-public-build"

  # Synchronize the new build to the local branch for submit.
  rsync -rtlvz --update "$blog-public-build/" "$blog-public-build-for-submit/"

  cd "$blog-public-build-for-submit"
  echo "=== Commit the changes of generated pages for public!"
  git add --all

  if  [ "$#" -eq 1 ]; then
      # When there is a command line argument, use it as the committing message.
      git commit -m `date +%F-%H-%M`": $1"
  else
      git commit -m `date +%F-%H-%M`
  fi

  echo "=== Start to push generated pages to remote branch for public!"
  http_proxy=192.168.0.100:1080 https_proxy=192.168.0.100:1080 git push

  # Go back to blog directory.
  cd "$blog"
else
  echo "There is nothing to push!"
fi
