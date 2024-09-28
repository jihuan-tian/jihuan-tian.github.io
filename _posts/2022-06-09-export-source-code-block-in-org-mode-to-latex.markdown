---
layout: post
title: Export source code block in Org mode to LaTeX
date: 2022-06-09
categories: [computer]
tags: [Emacs,Org-mode,LaTeX]
mathjax: false
---

When a source code block in the Org mode is exported as the HTML format, it can be typeset with syntax highlighting (By the way, for the Markdown format, this is supported by default by either a full-fledged Markdown editor or a static blog publishing system). If a line in the code contains many characters which exceeds the screen width, a horizontal scroll bar will appear for the `<pre>` node. However, when the source code block is exported to a LaTeX document, there is no support for syntax highlighting or word wrap by default, which makes the code uneasy to read. This problem can be solved by resorting to the `ox-latex` package for Emacs, which hands over the task of source code typesetting to the LaTeX package `listings`.

To enable the `ox-latex` package in Emacs, add the following code to `~/.emacs`.

```emacs-lisp
(require 'ox-latex)
(setq org-latex-listings t)
```

The configuration for `listings` can be set in the variable `org-latex-listings-options`. Here is the setting that is transcribed from the LaTeX template for my notes.

```emacs-lisp
(setq org-latex-listings-options
      '(("basicstyle" "\\ttfamily")
        ("keywordstyle" "\\color{blue}\\bfseries")
        ("commentstyle" "\\color{comment-green}")
        ("stringstyle" "\\color{magenta}")
        ("columns" "fullflexible")
        ("frame" "single")
        ("breaklines" "true")
        ("postbreak" "\\mbox{\\textcolor{red}{$\\hookrightarrow$}\\space}")))
```

If we do not want to configure the `listings` package in Emacs but in the LaTeX template, so that it can also be used when we directly write `tex` files, we can use the `\lstset` macro with a bunch of options. I prefer this method over the previous one.

```latex
\lstset{
  basicstyle=\ttfamily,
  keywordstyle=\color{blue}\bfseries,
  commentstyle=\color{comment-green},
  stringstyle=\color{magenta},
  columns=fullflexible,
  frame=single,
  breaklines=true,
  postbreak=\mbox{\textcolor{red}{$\hookrightarrow$}\space},
}
```

A snapshot of the source code exported to LaTeX is shown below, from which we can see the C++ keywords are highlighted and word wrap is enabled for long lines and properly signified with the `\hookrightarrow` symbol.

<p align="center"><img src="/figures/2022-06-08-source-code-typeset-by-listings.png" alt="Source code typeset by listings package" /></p>
<p align="center">Source code typeset by listings package</p>

{{ 2022-06-09-export-source-code-block-in-org-mode-to-latex | backlink }}
