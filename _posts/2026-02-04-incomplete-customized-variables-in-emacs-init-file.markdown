---
layout: post
title: Incomplete customized variables in Emacs init file
date: 2026-02-04
categories: [computer]
tags: [Emacs]
mathjax: false
---

Today, my Emacs failed to start. With the starting option `--debug-init`, I found out this was caused by some mismatched parentheses in `~/.emacs`. Furthermore, the mismatched parentheses were caused by the incomplete `custom-set-variables` sentence. Luckily, the missing part was found in the backup file `~/.emacs~`, so that I could restore the complete configuration file.

According to ChatGPT, this phenomenon can happen if there is an interruption when customized variables are being saved. Each saving causes all customized variables to be rewritten instead of only overwriting modified variables or adding new variables. At the moment, it takes a dozen seconds to save the customization in my case. Next time, I should be more patient when customizing variables.

Meanwhile, I&rsquo;ve moved the two sentences `custom-set-variables` and `custom-set-faces` from `~/.emacs` to a new file `~/.emacs-custom.el`. This new file is loaded at the end of `~/.emacs`.

```elisp
(setq custom-file "~/.emacs-custom.el")
(load custom-file t)
```

{{ "2026-02-04-incomplete-customized-variables-in-emacs-init-file" | backlink }}
