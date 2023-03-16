---
layout: post
title: Toolbar icons cannot be displayed in Emacs 27
date: 2023-03-16
categories: [computer]
tags: [Emacs]
mathjax: false
---

After I upgraded my Linux system to Debian Bullseyes, the toolbar icons in Emacs 27 were not visible anymore with only toolbar text left. Since the installed Emacs on my system was compiled with GTK+, I naturally tried to reconfigure the GNOME/GTK application style in KDE settings. However, this operation could only temporarily make the toolbar icons reappear. After restarting Emacs, the problem was still there.

Then I checked the configuration of GTK theme and icon theme in the file `~/.config/gtk-3.0/settings.ini`,

```text
gtk-theme-name=Breeze
gtk-icon-theme-name=breeze
gtk-fallback-icon-theme=breeze
```

which seemed correct.

Finally, according to this [post](https://www.reddit.com/r/kde/comments/slizni/changing_gnomegtk_application_style_theme_from/?utm_source=share&utm_medium=web2x&context=3), the solution for restoring Emacs toolbar GTK icons is to execute the following command after Emacs has fully started.

```text
dbus-send --session --dest=org.kde.GtkConfig --type=method_call /GtkConfig org.kde.GtkConfig.setGtkTheme 'string:Adwaita'
```
