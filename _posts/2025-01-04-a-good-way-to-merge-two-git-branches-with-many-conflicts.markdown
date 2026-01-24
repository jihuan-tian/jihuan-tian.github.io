---
layout: post
title: A good way to merge two Git branches with many conflicts
date: 2025-01-04
categories: [computer]
tags: [Git]
mathjax: false
---

When two Git branches have many conflicts during merging, simply accepting current changes or incoming changes for all conflicts will not make the resulted source code correct, because some lines of code from the incoming branch will not be treated as conflicts, if these lines in the current branch are not modified. Therefore, the resulted file interweaves the two input versions, which probably has many grammatical errors.

A good way to reliably merge two branches is to compare them respectively with the **merge-base** commit, which is the first common ancestor commit from which these two branches start to diverge. Then we will understand what on earth each branch has done to the merge-base. Only with such an understanding, the merging work will becomes meaningful. Luckily, the GitLens extension in VS Code provides this function in "GitLens Inspect → File history".

![img](/figures/2025-01-04_11-47-54-gitlens-inspect-file-history.png)

In the figure above, below "Merge changes", clicking on "Current changes <current-branch-name>" will compare the active file in the current branch with the merge-base, while clicking on "Incoming changes <SHA1 hash of the file in the incoming branch>" will compare the active file in the incoming branch with the merge-base.

**Good practice** Understand the modifications, then resolve the conflicts.

{{ "2025-01-04-a-good-way-to-merge-two-git-branches-with-many-conflicts" | backlink }}
