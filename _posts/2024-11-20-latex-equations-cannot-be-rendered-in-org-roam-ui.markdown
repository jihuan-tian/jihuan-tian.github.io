---
layout: post
title: LaTeX equations cannot be rendered in org-roam-ui
date: 2024-11-20
categories: [computer]
tags: [Emacs,Org-roam]
mathjax: false
---

**Phenomenon** All LaTeX equations are displayed as UTF-8 symbols in the preview panel of `org-roam-ui`, which cannot be rendered by KaTeX ([reference](https://github.com/org-roam/org-roam-ui/issues/285)).

**Cause** The file names for the fonts used by KaTeX in `~/.emacs.d/elpa/org-roam-ui-20221105.1040/out/_next/static/media` have been cut short. So the fonts cannot be found when loading the preview page.

**Solution** Do not install `org-roam-ui` via Emacs `package-install`. Use the `org-roam-ui` cloned from GitHub `https://github.com/org-roam/org-roam-ui.git`.

Now everything looks correct.

![img](/figures/2024-10-18_14-10-01-org-roam-ui-math-preview.png)

{{ "2024-11-20-latex-equations-cannot-be-rendered-in-org-roam-ui" | backlink }}
