---
layout: post
title: Probable memory leak in Emacs 27
date: 2023-03-29
categories: [computer]
tags: [Emacs,bug]
mathjax: false
---

# Condition

-   GNU Emacs 27.1 (build 1, x86\_64-pc-linux-gnu, GTK+ Version 3.24.24, cairo version 1.16.0) of 2023-02-23, modified by Debian
-   Loaded packages
    
    ```emacs-lisp
    (custom-set-variables
     '(package-selected-packages
       '(gnuplot helm-org clang-format org use-package ox-gfm ac-helm edit-indirect org-ref ac-ispell org-latex-impatient ac-math electric-cursor yasnippet auto-complete-auctex auto-complete zotxt zotelo auctex cmake-font-lock cmake-mode flycheck maxima flycheck-plantuml plantuml-mode tabbar session pod-mode markdown-mode magit initsplit htmlize graphviz-dot-mode folding eproject diminish csv-mode browse-kill-ring boxquote bm bar-cursor)))
    ```

# Phenomenon

If I intermittently use Emacs without closing it for hours, its memory consumption can be as high as 8 GB. I tend claim this indicates a memory leak. However, which loaded package is the culprit is still unknown. I guess the suspects might be `helm` and `auto-complete` related packages.

# Remedy

I&rsquo;ve tried executing `garbage-collect`, which has no effect

Next, I&rsquo;ve disabled the following packages to see if this high memory consumption can be relieved or removed.

Disabled packages which have been removed from the variable `package-selected-packages`:

-   `helm-org`
-   `ac-helm`
-   `ac-math`
-   `auto-complete-auctex`
-   `auto-complete`

Meanwhile, I run through the initialization script `~/.emacs` and comment out any unnecessary package requirements and configurations. Especially, the following lines of `helm` initialization code are commented out.

```emacs-lisp
(require 'helm-config)
(helm-mode 1)
(define-key global-map [remap find-file] 'helm-find-files)
(define-key global-map [remap occur] 'helm-occur)
(define-key global-map [remap list-buffers] 'helm-buffers-list)
(define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
(define-key global-map [remap execute-extended-command] 'helm-M-x)
(unless (boundp 'completion-in-region-function)
  (define-key lisp-interaction-mode-map [remap completion-at-point] 'helm-lisp-completion-at-point)
  (define-key emacs-lisp-mode-map       [remap completion-at-point] 'helm-lisp-completion-at-point))

(global-set-key (kbd "M-x") 'helm-M-x)
```

After doing the above and restarting Emacs with previous desktop loaded, the initial memory consumption is 74 MB. Running Emacs for hours, the memory consumption only increases to 200 MB.

# Lessons learned

-   Only load those frequently used packages to reduce the probability of being confronted with errors and bugs, which are either caused by a specific package or by the symbiotic effect of some packages.
-   It is worthy and rewarding to be patient to monitor and tune the behavior of our production tool.

{{ 2023-03-29-probable-memory-leak-in-emacs-27 | backlink }}
