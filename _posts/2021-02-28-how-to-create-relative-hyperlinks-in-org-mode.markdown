---
layout: post
title: How to create relative hyperlinks in Org mode?
date: 2021-02-28
categories: [computer]
tags: [Emacs,Org-mode,知识联接]
mathjax: false
---

Relative hyperlinks are indispensable for maintaining a bunch of inter-connected documents that have a fixed relative folder structure, when the whole folder tree is to be mounted at different locations on different computers. In Emacs Org mode, the fast key to insert a hyperlink is **C-c C-l**, which is bound to the function **org-insert-link**. However, according to its documentation below, we can only input a relative path at the prompt in the mini-buffer by pressing the key combination **C-u C-c C-l**, while the internal representation of the hyperlink still adopts an absolute path. This is not what I want.

> With a C-u prefix, prompts for a file to link to. The file name can be selected using completion. The path to the file will be relative to the current directory if the file is in the current directory or a subdirectory. Otherwise, the link will be the absolute path as completed in the minibuffer (i.e. normally ~/path/to/file). You can configure this behavior using the option \`org-link-file-path-type&rsquo;.

By further checking the documentation of the variable **org-link-file-path-type** mentioned above, we know that it is this variable that actually controls the internal hyperlink format. Valid values of this variable are:

-   `relative`: the path name in file links is stored relative to the current directory;
-   `absolute`: absolute path name is adopted, while the home directory is still represented as `~/`;
-   `noabbrev`: same as `absolute` but there is no abbreviation for the home directory;
-   `adaptive`: use relative path for files in the current directory and subdirectories of it, while for other files, use an absolute path.

Then, the configuration added to `~/.emacs` for enabling relative hyperlinks in Org mode is as below.

```lisp
(setq org-link-file-path-type 'relative)
```

Read more
* [Create hyperlinks in Org mode]({% post_url 2022-06-05-create-hyperlinks-in-org-mode %})
