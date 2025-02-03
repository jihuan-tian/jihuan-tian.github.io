---
layout: post
title: Use Emacs in console
date: 2025-02-01
categories: [computer]
tags: [Emacs]
mathjax: false
---

# Purpose

When I travel outside, the slow network speed does not allow me to connect to my home server with X11 forwarding. Therefore, using Emacs on the server should be in a console via SSH and consistent operational habits should be formed.


# Color theme tuning

**Phenomenon** I&rsquo;m using the solarized light color theme in Emacs. When I run Emacs in Konsole on my laptop, the color theme looks comfortable. When I run Emacs on the remote server via SSH from Konsole on my laptop, some colors look too dark, while some look too light to be identifiable. Initially, I thought this may be caused by inappropriate colors in the color scheme in Konsole. However, this is not the cause.

![img](/figures/2025-02-01_14-24-46-different-colors-in-local-and-remote-emacs.png "Different colors shown in local and remote Emacs.")

**Analysis** Execute `display-color-cells` in the two Emacs to check the number of colors supported. Emacs on my laptop returns 16777216, which is 24 bit true color, while Emacs on the remote server via SSH returns 256. In addition, if Emacs is started within a screen window, 24 bit color is not supported.

**Solution**

-   Add `export TERM=xtern-256color` and `export COLORTERM=truecolor` to `.bashrc`.
-   Use `tmux` instead of `screen` to have 24 bit color support.


# General operations

-   Delete a previous word in console Emacs
    
    The Emacs function is `backward-kill-word`. It is bound to `C-<backspace>` and `M-DEL`. In the console, `C-<backspace>` does not work. Use `M-DEL` instead, i.e. `Alt+backspace`.
-   Fold all subtrees in Org mode
    
    In Emacs GUI, `shift-tab` will do the work. In console mode, it is ineffective. Use `C-u TAB` instead.

{{ "2025-02-01-use-emacs-in-console" | backlink }}
