---
layout: post
title: Swiss Army knife I use for developing HierBEM
date: 2026-08-03
categories: [computer]
tags: [programming,hierbem]
mathjax: false
---

`imenu-list` and `eglot` (with the `clangd` LSP backend) in Emacs provides good enough code navigation for C++ programming involving templates and overloaded functions. However, source code indexing with `clangd` consumes too much memory, for example, it may exhaust all 16 GB space in the tempfs partition mounted at `/tmp`, which terminates the indexing process.

Therefore, I have only adopted this tool set in [HierBEM](https://jihuan-tian.github.io/hierbem-site/) for checking header file inclusion (much more accurate than VS Code IntelliSense) and code review. During normal coding, I have to disable `eglot` along with `clangd` to reserve enough space in `/tmp` for building the project and avoid lagging GUI response.

Without the LSP support, I resort to `consult-imenu` for jumping to function definitions. `consult-imenu` is based on [tree-sitter](https://tree-sitter.github.io/tree-sitter/), as long as the `c++-ts-mode` is enabled. Template code and overloaded functions are well supported.

To jump to a symbol such as a class name or variable name, I visit a tag table (the `TAGS` file) via the cross reference functionality provided by `xref`, which supports the `etags` backend.

If all the above tools do not help to find the desired entity, I can finally rely on pattern matching in the whole project. Then my choice is `rg`, which calls the command line tool `ripgrep`.

Therefore, the ensemble of small tools, namely, `imenu`, `imenu-list`, `consult`, `tree-sitter`, `eglot`, `clangd`, `etags`, `xref`, `rg`, `ripgrep`, if appropriately used in different scenarios, makes developing and refactoring C++ numerical libraries such as HierBEM in Emacs both feasible and efficient.

![Use imenu-list for code navigation in Emacs](/figures/2026-06-23_11-22-25-imenu-list@emacs.png)

{{ "2026-08-01-swiss-army-knife-i-use-for-developing-hierbem" | backlink }}
