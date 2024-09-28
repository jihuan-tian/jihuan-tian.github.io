---
layout: post
title: Create link to Joplin notes in Emacs Org mode
date: 2022-07-30
categories: [computer]
tags: [Emacs,Org-mode,Joplin,知识联接]
mathjax: false
---

The handling of hyperlinks in Emacs Org mode is flexible and versatile. For example, it supports links to files, websites, Usenet and email messages as well as IRC conversations. In addition, we can define our own hyperlink types and determine which operations will be performed when we click or export them.

For example, the external URL link for a Joplin note looks like this, which is not supported by Emacs Org mode.

    joplin://x-callback-url/openNote?id=a700a59f8a054e1aab97c296bf72fe3d

To make Org mode able to handle this link, we should add a new link type `joplin` by calling the `elisp` function `org-link-set-parameters`.

```emacs-lisp
(org-link-set-parameters
 ;; Name of the link type for Joplin node external URL link.
 "joplin"
 ;; Define the action when clicking on the link.
 :follow (lambda (url)
           ;; Open the link with the joplin script.
           (start-process "Joplin Session" nil "joplin" (concat "joplin:" url))))
```

In this function, we call the Joplin program using `start-process` and pass the full URL to it. The argument `url` of the `lambda` function associated with the `follow` action contains the string after the comma in the original link, i.e. `//x-callback-url/openNote?id=a700a59f8a054e1aab97c296bf72fe3d`. Therefore, we use `concat` to restore the original link. The second parameter of `start-process` is `nil`, which prevents Emacs from creating a buffer for the process.

Read more
* [Create hyperlinks in Org mode]({% post_url 2022-06-05-create-hyperlinks-in-org-mode %})

{{ "2022-07-30-create-link-to-joplin-notes-in-emacs-org-mode" | backlink }}
