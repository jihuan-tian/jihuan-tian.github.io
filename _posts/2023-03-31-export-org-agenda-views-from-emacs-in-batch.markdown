---
layout: post
title: Export Org agenda views from Emacs in batch
date: 2023-03-31
categories: [computer]
tags: [Emacs,Org-mode,GTD]
mathjax: false
---

As mentioned in the previous posts [以 Emacs Org mode 为核心的任务管理方案]({% post_url 2019-04-30-以Emacs Org mode为核心的任务管理方案 %}) and [将 Emacs Org mode 用于 GTD 任务管理]({% post_url 2019-09-30-将Emacs Org mode用于GTD任务管理 %}), the basic philosophy and key procedures of GTD can be realized with Org agenda. For frequent reviewing of todo lists in inbox, finished tasks and deadlines, I need to export corresponding agenda views into HTML files and host them on my local Apache server. This export operation can be automated in batch by starting Emacs from the command line and executing the lisp function `org-batch-store-agenda-views`.

First, customize the variable `org-agenda-custom-commands` according to [this post]({% post_url 2019-09-30-将Emacs Org mode用于GTD任务管理 %}).

To start Emacs from command line for the export, do not load the default `~/.emacs` initialization file, otherwise, Emacs will wait for user input about whether killing the server if there is already an Emacs process, or whether loading desktop files. Therefore, the command line option `-q` or `-Q` should be used.

Furthermore, the `htmlize` package should be loaded for the HTML export. And to make the exported HTML files look similar to the Emacs color theme, such as my favorite `solarized-light`, corresponding packages must be loaded. In addition, Emacs should not be started in batch mode, i.e. the option `--batch` should not be used. Otherwise, the `htmlize` package cannot load correct faces and the generated HTML files will have a white background instead of the light yellow.

Write a simplified initialization file `~/.emacs-batch-org` and start Emacs as below.

```text
emacs -Q -l ~/.emacs-batch-org --eval='(org-batch-store-agenda-views)' --kill
```

{{ 2023-03-31-export-org-agenda-views-from-emacs-in-batch | backlink }}
