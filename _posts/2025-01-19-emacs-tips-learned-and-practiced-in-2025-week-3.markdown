---
layout: post
title: Emacs tips learned and practiced in 2025 Week 3
date: 2025-01-19
categories: [computer]
tags: [Emacs]
mathjax: false
---

-   Use GitHub flavored markdown (provided by `ox-gfm`) instead of the default one (provided by `ox-md`).
-   Previously, I use `bibtex-completion` to add and edit notes for research papers. Now, I switch to `org-roam-bibtex` and call `tjh/orb-edit-note` to create a new or editing an existing bibliography note, which is in an independent org file.
-   When we compile Emacs 29 or 31, do not use `gtk` related x-toolkit and the pure GTK option `-pgtk`. Use `lucid` instead.
-   When there are multiple windows in a frame, use `balance-windows` to make them evenly distributed. This is especially useful when I open three horizontal windows for coding, reading documentation and running a shell.
-   Use `C-x r w` and `C-x r j` to save and restore window configurations. This is extremely useful when I work with a fixed set of buffers and windows, or I name them as different working modes. For example,
    -   Algorithm verification mode includes a window for C++ source code, a window for Julia or Octave script, a window for running Julia or Octave.
    -   Note-taking mode includes a window for writing Org roam note, a cloned window for reading related notes, maybe another window for editing LaTeX document, and a small window for its table of contents.
    -   Blog maintenance mode includes a window for Org roam note, a windows for its markdown export, a window for Jekyll markdown file.

{{ "2025-01-19-emacs-tips-learned-and-practiced-in-2025-week-3" | backlink }}
