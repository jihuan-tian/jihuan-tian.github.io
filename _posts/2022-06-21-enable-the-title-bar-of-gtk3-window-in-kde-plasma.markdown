---
layout: post
title: Enable the title bar of GTK+ 3 window in KDE Plasma
date: 2022-06-21
categories: [computer]
tags: [KDE]
mathjax: false
---

GTK+ 3 applications such as `nautilus`, `evince`, `gthumb`, `midori`, etc. do not have title bar displayed in KDE Plasma. According to GitHub project [gtk3-nocsd](https://github.com/PCMan/gtk3-nocsd), this is caused by the header bar and client-side decoration introduced by GTK+ 3.10 and further versions.

> Since Gtk+ 3.10, its developers added a so-called header bar or custom title bar. With this and the client-side decoration, the original title bar and window border provided by the window manager are disabled by Gtk+. This makes all Gtk+ 3 programs look alike. Even worse, this may break some window manager or compositors.
> 
> Unfortunately, the Gtk+ developers decided to be against the existing standards and provide &ldquo;no option&rdquo; to turn it off.

It is cumbersome to add a customized window rule for each GTK+ 3 application. The definitive solution is to install the Debian package `gtk3-nocsd`.

![img](/figures/2022-06-21_10-05-33-midori-without-title-bar.png "Midori without title bar")

![img](/figures/2022-06-21_10-07-03-midori-with-title-bar.png "Midori with title bar after installation of gtk3-nocsd")

{{ "2022-06-21-enable-the-title-bar-of-gtk3-window-in-kde-plasma" | backlink }}
