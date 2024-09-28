---
layout: post
title: Squash several minor Git commits into a single one
date: 2023-03-27
categories: [computer]
tags: [Git]
mathjax: false
---

In principle, it is not recommended to perform Git commits so frequently as for each minor changes, such as correcting typos, adding documentation, re-formatting the source code, etc. A good opportunity to a Git commit is when a new functionality is added or an actual performance improvement is achieved.

However, if there have been after all several minor changes coming from careless commits, it is necessary to combine them with a recent meaningful big change. In Git terminology, this operation is called rebase.

Assume we need to combine 3 recent commits into a single one, the following command should be executed.

```bash
git rebase -i HEAD~3
```

Then a default text editor will be opened for editing the rebase commands, where each line in the buffer represents a commit. We should replace the first keyword `pick` with `squash` <sup><a id="fnr.1" class="footref" href="#fn.1">1</a></sup> for each line except the first line, which means all the other two commits will be merged into the first.

After finishing the above edit, Git prompts us to write a new commit message. In the opened editor, the messages for all the three old commits will be presented, and we just need to comment out unnecessary messages or add new information. Then a new commit will be created and the squashing operation finishes.

## Footnotes

<sup><a id="fn.1" class="footnum" href="#fnr.1">1</a></sup> squash v. to stop sth from
continuing; to destroy sth because it is a problem for you

{{ "2023-03-27-squash-several-minor-git-commits-into-a-single-one" | backlink }}
