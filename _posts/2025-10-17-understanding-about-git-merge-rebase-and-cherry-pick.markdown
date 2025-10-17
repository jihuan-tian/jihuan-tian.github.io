---
layout: post
title: "Understanding about Git merge, rebase and cherry-pick"
date: 2025-10-17
categories: [computer]
tags: [Git]
mathjax: false
---

To understand the differences between Git merge, rebase and cherry-pick, we need to know these points:

1.  How does Git generally merge two commits into a new commit?
2.  How is a new commit created during the three types of operations?
3.  How is the new commit linked into the existing commit history?
4.  How does a branch tip move after the operation?


# Merge two commits into a new commit

After first, we need to know how Git creates a new commit by merging two existing commits. There are two cases:

-   Fast-forward merge
    -   If one of the commit is the ancestor of the other commit and we are merging the descendant commit into the ancestor commit, a fast-forward merge will be performed.
    -   If we are merging the ancestor commit into the descendant commit, Git will do nothing and return a message "Already up to date.".
    -   When a fast-forward merge happens, no new commit will be created.
-   Three-way merge
    -   It happens when the two input commits are not on a same history chain, i.e. no commit is the ancestor of the other one.
    -   A three-way merge will create a new commit, which involves the two input commits and their most recent common ancestor.
    -   During a three-way merge, commit diference is produced in this way:
        
        Let `B` be the first commit, `C` be the second commit and `A` be their most recent common ancestor. Git first computes changes from `A` to `B` (written as `diff1`) and from `A` to `C` (written as `diff2`). Next, Git creates a new commit by applying `diff1` and `diff2` to `A`. A three-way merge is line-based, which means if changes made in `diff1` and `diff2` are about different lines, there will be no merge conflicts, otherwise, if `diff1` and `diff2` contain changes on a same line, there will be a conflict and needs to be manually resolved.


# Merge

-   The target branch is the current branch and the source branch is the other branch.
-   Git creates a a new commit by merging tip commits in the two input branches.
-   If a fast-forward merge happens:
    -   There is no new commit created.
    -   The tip of the target branch moves to the same commit to which the tip of the source branch also points, i.e. the two tips overlap.
-   When a three-way merge happens:
    -   A new commit is created.
    -   The tip of the target branch moves to this new commit, while the tip of the source branch does not change.
    -   The input two commits are the ancestors of this new commit.
-   We use merge when we want to keep the working history in a topic branch, even though divergent and merging branches will make the repository graph look messy.

![img](/figures/2025-10-17-15-38-40-git-merge_export.png)


# Rebase

-   The source branch is the current branch and the target branch is the other branch.
-   A range of commits are rebased from the source branch onto the target branch. For each of them, Git creates a new commit by merging this source commit with the tip commit in the target branch.
-   These newly created commits preserve the same chain relation as their corresponding commits in the source branch.
-   This chain of new commits is appended to the tip of the target branch, while the range of commits in the source branch before rebasing are deleted.
-   The tip of the current (source) branch moves to the last commit in this new commit chain and the tip of the target branch does not move.
-   We use rebase to keep a almost linear project history, which looks cleaner than Git merge. However, the original work in the topic branch is modified.
-   Handling conflicts
    -   Resolve conflicts manually, then add or remove modified files and run `git rebase --continue`.
    -   Skip the conflicting commit: `git rebase --skip`.
    -   Use `git rebase --abort` to return to the state before rebasing.

-   Possible operation after rebase
    
    Since the tip of the target branch is now an ancestor of the source branch, we can fast-forward merge the target branch into the source branch, then delete the source branch.
    
    ```text
    git checkout <target-branch>
    git merge <source-branch>
    git branch -d <source-branch>
    ```

![img](/figures/2025-10-17-15-40-14-git-rebase_export.png)


# Cherry-pick

-   Same as merge, the target branch is the current branch and the source branch is the other branch.
-   One or several commits from the source branch can be cherry-picked into the target branch. For each cherry commit, Git creates a new commit by merging it with the tip commit of the current branch.
-   This sequence of new commits are put into a chain in the same order as their counterparts in the source branch. This new chain is appended to the tip of the target branch.
-   The cherry commits in the source branch are not changed or deleted.
-   The tip of the current branch moves to the last commit in the new commit chain, while the tip of the source branch does not move.
-   We use cherry-pick to acquire interested contributions from a topic branch into our working branch, while the commits in the topic branch are preserved.
-   Handling conflicts
    -   Manually resolve conflicts, then add or remove files and run `git cherry-pick --continue`.
    -   Skip the conflicting commit: `git cherry-pick --skip`.
    -   Abort the cherry-pick and return to the state before: `git cherry-pick --abort`

-   Possible operation after cherry-pick
    
    After we cherry-pick interested commits from a topic branch, we may want to delete the topic branch by running `git branch -D <topic-branch>`. Do not use `-d`, otherwise there will be an error:
    
    ```text
    error: The branch '<topic-branch>' is not fully merged.
    If you are sure you want to delete it, run 'git branch -D dev'.
    ```

![img](/figures/2025-10-17-15-49-13-git-cherry-pick_export.png)

{{ "2025-10-17-understanding-about-git-merge-rebase-and-cherry-pick" | backlink }}
