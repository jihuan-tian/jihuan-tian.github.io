---
layout: post
title: Modes that I use for software development in Emacs
date: 2026-01-05
categories: [computer]
tags: [Emacs]
mathjax: false
---

-   I edit source code in both Emacs and VS Code. `auto-revert-mode` should enabled be so that Emacs can automatically reload a buffer whenever the associated file is modified in VS Code.
-   `scroll-all-mode` is used to synchronize cursor movement in opened windows in a same frame. When comparing two similar files, this mode is very useful.
-   I enable `flyspell-prog-mode` when editing source code, which will limit spell checking to comment.
-   I enable `texfrag-mode` to render LaTeX fragments in the comment. A filter function should be defined to transform the LaTeX fragments written in Doxygen format to LaTeX code.
    
    ```elisp
    (defun texfrag-cpp-filter (str)
      "`texfrag-cpp-filter' filtering STR for C++ programming"
      (setq str (replace-regexp-in-string "^ *\\(/\\*\\)\\|\\(\\* \\)" "" str)))
    ```
    
    Then we assign this function to `texfrag-equation-filter`
    
    ```elisp
    (setq texfrag-equation-filter #'texfrag-cpp-filter)
    ```
    
    ![img](/figures/2024-05-16_13-24-21-texfrag-for-programming@emacs.png)

-   When writing commit message in Magit, I enable `flyspell-mode` for spell checking and `auto-fill-mode` for wrapping long lines. Because the commit messages will not be wrapped when being viewed in Gitlab, `auto-fill-mode` is needed.
    
    Now detailed commit messages in Gitlab are easy to read as below.
    
    ![img](/figures/2026-01-05-17-34-52-screenshot.png)

{{ "2026-01-05-modes-that-i-use-for-software-development-in-emacs" | backlink }}
