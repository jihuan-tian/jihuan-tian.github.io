---
layout: post
title: Commit all modified files to Git
date: 2022-02-25 09:47
categories: [computer]
tags: [Git]
---

Following these steps will do the work.

1. Use `git status`  to check the file status.
2. Use `grep` to search for the `modified` keyword.  
3. Extract the second column by using `cut` with the delimiter `:`.
4. Remove surplus white spaces in front of the data field by using `sed`.
5. Connect the above commands in sequence via pipes.
6. Quote the command list using \`\`, the result of which will be passed as the argument of `git add`.

The train of commands looks like this.

```bash
git add `git status | grep modified | cut -d ":" -f 2 | sed -e 's/^\s*//'`
```

Similarly, this method can be adapted for committing files in other status.

{{ "2022-02-25-Commit-all-modified-files-to-Git" | backlink }}
