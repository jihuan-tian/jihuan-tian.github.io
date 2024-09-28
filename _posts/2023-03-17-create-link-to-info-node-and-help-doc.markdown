---
layout: post
title: Create link to Info node and help document in Emacs Org mode
date: 2023-03-17
categories: [computer]
tags: [Emacs,Org-mode,知识联接]
mathjax: false
---

It is convenient to browse Info documents about various programs and libraries on Linux in Emacs. If we want to refer to a particular Info node from an Org note, it is possible to create a hyperlink to it using the link type `elisp:`.

First, we should get a copy of the Info node name by pressing `c` in an `Info` session. Then back in Org mode, we create a hyperlink as `[[elisp:(info "<info-node-name>")][<link-name>]]`.

Similarly, a hyperlink can also be created in Org which jumps to the help of a function, variable or key-bindings, etc. For example,

-   `[[elisp:(describe-function 'car)][elisp function car]]` links to the help document of the elisp function `car`;
-   `[[elisp:(describe-variable 'debug-on-error)][elisp variable debug-on-error]]` links to the help document of the lisp variable `debug-on-error`;
-   `[[elisp:(describe-key (kbd "C-c C-c"))][Key binding C-c C-c]]` links to the help document of the key binding `C-c C-c`.

In addition to using the link type `elisp:`, a simpler method is to use the hyperlink type `info:` for Info document and `help:` for help document. For example, `[[info:elisp#Introduction][Elisp Introduction section]]` links to the &ldquo;Introduction&rdquo; section in the Elisp Info document and `[[help:debug-on-error][debug-on-error]]` links to the help document for the elisp variable `debug-on-error`.

Read more
* [Create hyperlinks in Org mode]({% post_url 2022-06-05-create-hyperlinks-in-org-mode %})

{{ 2023-03-17-create-link-to-info-node-and-help-doc | backlink }}
