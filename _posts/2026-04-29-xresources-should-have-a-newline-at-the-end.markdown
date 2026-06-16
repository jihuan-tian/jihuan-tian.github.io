---
layout: post
title: Xresources should have a newline at the end
date: 2026-04-29
categories: [computer]
tags: [Linux,emacs]
mathjax: false
---

<a id="org08beb8e"></a>

# Phenomenon

Today, after I started KDE, the cursor became extremely small in some applications, such as konsole, KDE system settings, Anki, KDE desktop. However when the cursor was in GTK based applications such as Firefox, its size was normal. I tried to change the cursor size in KDE system settings but got no effect.


<a id="org98a3b5a"></a>

# Analysis

Remembering that I modified the menu font used by Emacs yesterday by editing `$HOME/.Xresources`, I doubt this may be the cause.

```conf-xdefaults
Xpdf*paperColor: rgb:f6/f0/de
Xpdf*fontList: -adobe-helvetica-medium-r-normal--35-0-0-0-p-0-iso8859-1
gv*font: -adobe-helvetica-medium-r-normal--35-0-0-0-p-0-iso8859-1
Xft.dpi: 161
Emacs.pane.menubar.font: Noto Sans CJK SC-12
Emacs.menu*.font: Noto Sans CJK SC-12
Emacs.dialog*.font: Noto Sans CJK SC-12
```

So I execute `xrdb -query | grep -i cursor` to check cursor related settings in the X server resource database and get this:

```bash
Emacs.dialog*.font:     Noto Sans CJK SC-12Xcursor.theme: WhiteSur-cursors
Xcursor.size:   48
```

The configuration for the cursor theme has been mixed with the Emacs dialog font configuration. It is obvious that when I ran `xrdb -merge $HOME/.Xresources`, the system configuration was appended to my configuration without adding a new line.


<a id="org5510862"></a>

# Cause and solution

Yesterday I edited `$HOME/.Xresources` in Emacs using the `conf-xdefaults-mode`. In this mode, the Emacs variable `require-final-newline` is `nil`, while other modes I often use, such as `org-mode`, `c++-mode`, etc., set this variable to `t`.

Solution: manually adding a newline to the end of `$HOME/.Xresources` and running `xrdb -load $HOME/.Xresources`. With this `-load` option, previous values will be overwritten.

{{ "2026-04-29-xresources-should-have-a-newline-at-the-end" | backlink }}
