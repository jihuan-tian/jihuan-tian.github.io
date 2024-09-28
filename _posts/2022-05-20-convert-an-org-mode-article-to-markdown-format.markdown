---
layout: post
title: Convert an Org mode article to Markdown format
date: 2022-05-20
categories: [computer]
tags: [Markdown,Org-mode,Emacs]
mathjax: false
---

The default Markdown export functionality provided by Emacs Org mode has a flaw in that it cannot preserve the grammatical highlight in a code block. This is because the Org mode environment `#+BEGIN_SRC ... #+END_SRC` is simply transformed into indented code in the Markdown file with the surrounding \`\`\` symbols missing.

This problem can be solved by installing the package `ox-gfm`, which implements a Markdown export back-end with GitHub flavor. It is suggested to load `ox-gfm` by via `usage-package` as shown below (`usage-package` is also a package which can be installed from `MELPA`).

```lisp
(use-package ox-gfm
  :defer 3
  :after org)
```

The following loading method via `eval-after-load` is not recommended.

```lisp
(eval-after-load "org"
  '(require 'ox-gfm nil t))
```

It will lead to the following error.

    Debugger entered--Lisp error: (error "Unknown \"nil\" back-end: Aborting export")
      signal(error ("Unknown \"nil\" back-end: Aborting export"))
      error("Unknown \"%s\" back-end: Aborting export" nil)
      org-export-barf-if-invalid-backend(nil)
      org-export-as(gfm nil nil nil nil)
      org-export-to-buffer(gfm "*Org GFM Export*" nil nil nil nil nil #f(compiled-function () #<bytecode 0x1a2ea5d>))
      org-gfm-export-as-markdown()
      funcall-interactively(org-gfm-export-as-markdown)
      call-interactively(org-gfm-export-as-markdown record nil)
      command-execute(org-gfm-export-as-markdown record)
      helm-M-x(nil #("org-gfm-export-as-markdown" 0 26 (match-part "org-gfm-export-as-markdown")))
      funcall-interactively(helm-M-x nil #("org-gfm-export-as-markdown" 0 26 (match-part "org-gfm-export-as-markdown")))
      call-interactively(helm-M-x nil nil)
      command-execute(helm-M-x)

After loading `ox-gfm`, when pressing `C-c C-e` in Org mode, a new export option will be displayed as below. Then a better Markdown transformation can be produced than the default back-end in Org mode.

![ox-gfm export](/figures/2022-05-20_11-45-26-ox-gfm-export.png)

{{ "2022-05-20-convert-an-org-mode-article-to-markdown-format" | backlink }}
