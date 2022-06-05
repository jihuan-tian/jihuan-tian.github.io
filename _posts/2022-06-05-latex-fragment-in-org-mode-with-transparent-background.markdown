---
layout: post
title: LaTeX fragment in Org mode with transparent background
date: 2022-06-05
categories: [computer]
tags: [Emacs,Org-mode,LaTeX]
mathjax: false
---

LaTeX fragment preview provided by Emacs Org mode is a handy mechanism for acquiring an almost real-time LaTeX input and rendering experience, which transforms the tedious math note-taking into leisure and aesthetic.

There are three back-ends that can be used to convert LaTeX source code snippets into math equation images, namely, `dvipng`, `dvisvgm` and `imagemagick`. Among them, `dvisvgm` produces vector graphics, which is my first choice. To set it as the default back-end, add the following configuration.

```emacs-lisp
(setq org-preview-latex-default-process 'dvisvgm)
```

Detailed configurations for these back-ends including command name and options are configured in the variable `otpion~org-preview-latex-process-alist`. Other options for LaTeX image generation such as foreground, background, scaling, etc. are controlled by `org-format-latex-options`.

To generate LaTeX fragment images with a transparent background, which will be compatible with different Emacs color themes, we should **not** set the property `:background` in `org-format-latex-options` as `Transparent`, but `default` instead. The generated LaTeX fragments in my solarized-light color theme looks like this.

<p align="center"><img src="/figures/2022-05-27_18-00-12-latex-fragment-transparent-background-in-org.png" alt="" /></p>
