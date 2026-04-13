---
layout: post
title: Emacs GUI operations trigger system freeze
date: 2026-04-13
categories: [computer]
tags: [Emacs]
mathjax: false
---

<a id="org8776806"></a>

# Phenomenon

Clicking Emacs buttons, expanding menus, opening dropdown lists, or even displaying a popup message when the mouse is over a link, will cause my Linux system to freeze. During this freeze, several processes unrelated to Emacs occupy 100% CPU resource, such as python (started by Anki), sunshine, zotero, etc.


<a id="org1c676c1"></a>

# Trial and cause

After asking ChatGPT and trying its suggestions, solutions without effects:

-   disabling compositor in KDE does not help.
-   disabling desktop effects in KDE does not help.
-   previous migration from GTK3 to lucid x-toolkit when compiling Emacs does not help.

The final cause is **probably** the input method fcitx5.


<a id="org5ba2096"></a>

# Solution

Create an alias in `$HOME/.bashrc`:

```bash
alias emacs="GTK_IM_MODULE=none QT_IM_MODULE=none XMODIFIERS=@im=none emacs"
```

In Emacs, use `pyim` as the input method. `toggle-input-method` is bound to `M-\`.

```elisp
(global-set-key (kbd "M-\\") #'toggle-input-method)
```


<a id="orgd71d16f"></a>

# Lessons learnt

Emacs itself is a very reliable and robust system. Errors and bugs often come from its interaction with other libraries and tools, i.e. as a problem source, collaboration or synergy plays much important role than intrinsic issues. Therefore, when using a complex and powerful tool, we had better rely on its own infrastructure and functionalities, with few external dependencies as possible.

{{ "2026-04-13-emacs-gui-operations-trigger-system-freeze" | backlink }}
