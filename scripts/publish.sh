#!/bin/bash

cd "$blog"

if  [ "$#" -eq 1 ]; then
    # When there is a command line argument, use it as the commit message.
    commit_msg="$1"
else
    # Otherwise, use a timestamp as the commit message.
    commit_msg=`date +%F-%H-%M`
fi

is_need_commit=`git status | grep "nothing to commit, working tree clean"` 

if [ -z "$is_need_commit" ]; then
  echo "=== Commit the changes!"
  git add --all
  # Remove _config.yml from the commit, since it is modified for local build.
  git restore --staged _config.yml
  git commit -m "$commit_msg"
else
  echo "=== There are no changes to commit!"
fi

is_need_push=`git status | grep "Your branch is up to date with 'origin/main'."`
if [ -z "$is_need_push" ]; then
  echo "=== Start to push source to remote branch!"
  http_proxy=192.168.0.100:32750 https_proxy=192.168.0.100:32750 git push
else
  echo "There is nothing to push!"
fi

# Go to the public folder and pull the latest modifications.
sleep 5
cd "$blog-public"
is_need_pull=`git status | grep "Already up to date."`
if [ -z "$is_need_pull" ]; then
    echo "=== Start to pull for public from remote branch!"
    http_proxy=192.168.0.100:32750 https_proxy=192.168.0.100:32750 git pull
    echo "=== Build blog for public!"
    jekyll build
    echo "=== Synchronize the new build to public for submit!"
    rsync -rtlvz --update --delete --exclude="/.git" "$blog-public/_site/" "$blog-public-for-submit/"

    cd "$blog-public-for-submit"

    is_need_commit=`git status | grep "nothing to commit, working tree clean"`
    if [ -z "$is_need_commit" ]; then
	echo "=== Commit the changes of generated pages for public!"
	git add --all
	git commit -m "$commit_msg"
	echo "=== Start to push generated pages to remote branch for public!"
	http_proxy=192.168.0.100:32750 https_proxy=192.168.0.100:32750 git push
    else
	echo "=== There are no changes to commit for submit to public!"
    fi
else
    echo "=== No need to pull or build for public from remote branch!"
fi

# Go back to blog directory.
cd "$blog"
