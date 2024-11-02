---
layout: post
title: Conflict between YASnippet and cdlatex
date: 2024-11-02
categories: [computer]
tags: [Emacs]
mathjax: false
---

Today, when I edited the LaTeX document for my personal project, the `cdlatex` expansion took precedence over the YASnippet expansion, which made the latter not function properly. Such a phenomenon has not appeared before.

**Solution**

1.  Create the following Elisp function `tjh/cdlatex-yas-expand`, in which the YASnippet expansion will be tried first. If successful, this function returns `t` and the default `cdlatex` expansion will be ignored. Otherwise, the `cdlatex` expansion will be used.
    
    ```elisp
    (defun tjh/cdlatex-yas-expand ()
      "Resolve the conflict between cdlatex and yasnippet. When this
    function returns true, the default `cdlatex-tab` will not be
    executed. The effect of function is to first try yasnippet
    expansion, then cdlatex expansion."
      (interactive)
      (if (or (bound-and-true-p yas-minor-mode)
              (bound-and-true-p yas-global-mode))
          (if (yas-expand)
              t
            nil)
        nil))
    ```
2.  Add `tjh/cdlatex-yas-expand` to `cdlatex-tab-hook`.
    
    ```elisp
    (add-hook 'cdlatex-tab-hook 'tjh/cdlatex-yas-expand)
    ```

{{ "2024-11-02-conflict-between-yasnippet-and-cdlatex" | backlink }}
