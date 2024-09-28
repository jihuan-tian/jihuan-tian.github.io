---
layout: post
title: Old Dired+ does not work in Emacs 27
date: 2023-03-16
categories: [computer]
tags: [Emacs]
mathjax: false
---

# Conditions

-   GNU Emacs 27.1 (build 1, x86\_64-pc-linux-gnu, GTK+ Version 3.24.24, cairo version 1.16.0) of 2023-02-23, modified by Debian
-   Dired+ version 21.2

# Phenomenon

Pressing `R` in Dired mode produces the following error message.

```text
dired-do-create-files: Wrong number of arguments: (lambda (&optional localp arg filter distinguish-one-marked) "Return names of the marked files as a list of strings.
The list is in the same order as the buffer, that is, the car is the
first marked file.
Values returned are normally absolute file names.
Optional arg LOCALP as in `dired-get-filename'.
Optional second argument ARG specifies files to use instead of marked.
Usually ARG comes from the command's prefix arg.
If ARG is an integer, use the next ARG files (previous -ARG, if < 0).
If ARG is a cons with element 16, 64, or 256, corresponding to
`C-u C-u', `C-u C-u C-u', or `C-u C-u C-u C-u', then use all files
in the Dired buffer, where:
16 includes NO directories (including `.' and `..')
64 includes directories EXCEPT `.' and `..'
256 includes ALL directories (including `.' and `..')
If ARG is otherwise non-nil, use the current file.
Optional third argument FILTER, if non-nil, is a function to select
some of the files: those for which (funcall FILTER FILENAME) is
non-nil.
If DISTINGUISH-ONE-MARKED is non-nil, then return (t FILENAME) instead
of (FILENAME), if only one file is marked.  Do not use non-nil
DISTINGUISH-ONE-MARKED together with FILTER." (let ((all-of-them (save-excursion (prog1 (let ((inhibit-read-only t) (newarg arg) multi-C-u case-fold-search found results) (if (and (consp newarg) (> ... 4)) (progn (setq newarg ... multi-C-u t))) (if (and newarg (not multi-C-u)) (if (integerp newarg) (progn ... ...) (list ...)) (let (... next-position) (save-excursion ... ... ...) (if ... ...) (if found results ...)))) (dired-move-to-filename)))) result) (if (not filter) (if (and distinguish-one-marked (eq (car all-of-them) t)) all-of-them (nreverse all-of-them)) (let ((--dolist-tail-- all-of-them) file) (while --dolist-tail-- (setq file (car --dolist-tail--)) (if (funcall filter file) (progn (setq result (cons file result)))) (setq --dolist-tail-- (cdr --dolist-tail--)))) result))), 5
```

Initially, I searched on [Stack Overflow](https://stackoverflow.com/a/52067576) and thought my problem might originate from the same cause. However, the solution did not work after all, because the reported phenomenon was different from mine.

Then I started Emacs by executing `emacs -Q` from the command line, which disabled loading all configurations. This time, the file name could be changed in the default Dired mode. This meant Dired mode itself in Emacs 27.1 worked normally.

Next, I ran though my `~/.emacs` to check configurations related to Dired. Then I noticed the configuration for Dired+.

```emacs-lisp
(require 'dired+)
(toggle-diredp-find-file-reuse-dir t)
```

`dired+.el` in my Emacs had not been updated for a long time. Maybe it was the culprit behind the scene. This thought was then verified by offloading it.

Finally, I downloaded a new version of [dired+.el](https://www.emacswiki.org/emacs/download/dired%2b.el) and the problem was solved.

# Lessons learned

1.  The phenomenon reported in Stack Overflow is different from mine. Hence the answer should not be taken for granted.
2.  Starting an application without loading any extensions or modules is helpful to localize bug or exclude suspected causes.
3.  Nowadays, a fully-fledged software program, such as Emacs, LibreOffice, Eclipse, etc. is already a complicated system or platform, which integrated a panoply of plugins and extensions. As the main software program upgrades with time, the complementary gadgetry should also be maintained alongside.

{{ "2023-03-16-old-diredp-does-not-work-in-emacs27" | backlink }}
