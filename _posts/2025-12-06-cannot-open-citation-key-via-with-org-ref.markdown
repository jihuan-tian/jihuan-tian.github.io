---
layout: post
title: Cannot open citation key via with org-ref
date: 2025-12-06
categories: [computer]
tags: [Org-mode,bug]
mathjax: false
---

<a id="org4caf092"></a>

# Phenomenon

After I upgraded `org-ref-20250828.2122` to `org-ref-20251123.1710`, I cannot open a BibTeX citation key any more in Org mode with the following message.

```text
transient-setup: Symbol’s value as variable is void: $
```


<a id="org92c03c6"></a>

# Analysis

Enabling `debug-on-error`, I can see `org-ref` has migrated from `hydra` to `transient` for creating popup menus and it is the `transient` package that causes this problem.


<a id="org6560e82"></a>

# Solution

Delete `transient.elc` in the folder `elpa/transient-20251129.1551` and restart Emacs. Or reinstall this package via `package-reinstall`.


<a id="org19ed7bf"></a>

# Lessons learnt

Do not update Emacs or its packages so often. If the current Emacs can work smoothly, just stick to it. Otherwise, fiddling with Emacs diverts our original focus on more important works.

{{ "2025-12-06-cannot-open-citation-key-via-with-org-ref" | backlink }}
