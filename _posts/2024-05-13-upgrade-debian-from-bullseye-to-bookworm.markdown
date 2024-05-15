---
layout: post
title: Upgrade Debian from Bullseye to Bookworm
date: 2024-05-13
categories: [computer]
tags: [Debian]
mathjax: false
---

- [Basic information](#org1497414)
- [After `sudo apt upgrade`](#org8d660de)
- [During `sudo apt dist-upgrade`](#orge6a3dd4)
- [After `sudo apt dist-upgrade`](#orgc17398d)
  - [Anki](#orgd24ea13)
  - [Emacs](#org98d1ed9)
  - [Python](#org7dd4b3a)
  - [Jekyll](#orgc835d28)
  - [Texlive based LaTeX](#org3ee59af)
  - [GNU Octave](#org23d9778)
  - [KDE Plasma desktop](#org7a5f4ff)
  - [PulseAudio](#orgaaf499c)
  - [Wacom](#org4f3d147)
  - [Video player](#orgdb17c7c)

Upgrading a Linux system is always a non-trivial task. In the following, I&rsquo;ll list the phenomena and problems I met during upgrading Debian from Bullseye to Bookworm.


<a id="org1497414"></a>

# Basic information

Debian 12 Bookworm was released on 2023-06-10. Up to now, it includes the following key updates:

-   Linux kernel 6.1 series
-   Cryptsetup 2.6
-   GNU Compiler Collection 12.2
-   The GNU C Library 2.36
-   LLVM/Clang toolchain 13.0.1, 14.0 (default), and 15.0.6
-   Emacs 28.2
-   CMake 3.25.1: *However, this is not enough for C++20.*
-   GNU Octave 7.3.0
-   Python 3.11
-   Ruby 3.1
-   Julia 1.5.3
-   LibreOffice 7.5.3.2


<a id="org8d660de"></a>

# After `sudo apt upgrade`

```text
Cannot load module /usr/lib/x86_64-linux-gnu/gtk-3.0/3.0.0/immodules/im-fcitx.so: GModule (/usr/lib/x86_64-linux-gnu/gtk-3.0/3.0.0/immodules/im-fcitx.so) initialization check failed: GLib version too old (micro mismatch)
/usr/lib/x86_64-linux-gnu/gtk-3.0/3.0.0/immodules/im-fcitx.so does not export GTK+ IM module API: GModule (/usr/lib/x86_64-linux-gnu/gtk-3.0/3.0.0/immodules/im-fcitx.so) initialization check failed: GLib version too old (micro mismatch)
Processing triggers for libgtk2.0-0:amd64 (2.24.33-2) ...
Cannot load module /usr/lib/x86_64-linux-gnu/gtk-2.0/2.10.0/immodules/im-fcitx.so: GModule (/usr/lib/x86_64-linux-gnu/gtk-2.0/2.10.0/immodules/im-fcitx.so) initialization check failed: GLib version too old (micro mismatch)
/usr/lib/x86_64-linux-gnu/gtk-2.0/2.10.0/immodules/im-fcitx.so does not export GTK+ IM module API: GModule (/usr/lib/x86_64-linux-gnu/gtk-2.0/2.10.0/immodules/im-fcitx.so) initialization check failed: GLib version too old (micro mismatch)
```


<a id="orge6a3dd4"></a>

# During `sudo apt dist-upgrade`

-   The following packages were removed but some other packages still had dependencies on them. However, after `dist-upgrade` was finished, the following packages were reinstalled automatically.
    
    ```text
    Removing texlive-bibtex-extra (2020.20210202-3) ...
    Removing texlive-fonts-extra (2020.20210202-3) ...
    dpkg: texlive-extra-utils: dependency problems, but removing anyway as you requested:
     doxygen-latex depends on texlive-extra-utils.
    
    Removing texlive-extra-utils (2020.20210202-3) ...
    dpkg: texlive-font-utils: dependency problems, but removing anyway as you requested:
     latex-cjk-common depends on texlive-font-utils (>= 2007.dfsg.2-1).
     doxygen-latex depends on texlive-font-utils.
    
    Removing texlive-font-utils (2020.20210202-3) ...
    dpkg: texlive-binaries
    
    Removing texlive-latex-base (2020.20210202-3)
    
    dpkg: texlive-latex-extra: dependency problems, but removing anyway as you requested:
    
    dpkg: texlive-pictures: dependency problems, but removing anyway as you requested:
    ```


<a id="orgc17398d"></a>

# After `sudo apt dist-upgrade`


<a id="orgd24ea13"></a>

## Anki

The GUI interface of Anki (2.1.49) does not show anything.

Solution: upgrade to Anki 24.04.1 with Qt6. Install Debian packages `qt6-base-dev` and `qt6-base-dev-tools` to acquire Qt6.


<a id="org98d1ed9"></a>

## Emacs

-   LaTeX fragments previewed in Org mode become extremely large. Changing the scale factor from 2.5 to 1.5 solves the problem. The configuration is stored in the variable `org-format-latex-options`:
    
    ```elisp
    (custom-set-variables
     '(org-format-latex-options
       '(:foreground default :background default :scale 1.5 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                     ("begin" "$1" "$" "$$" "\\(" "\\["))))
    ```

-   Mixed installation of Org mode error
    
    ```text
    Org mode version 9.5.5 (release_9.5.5 @ mixed installation! /usr/share/emacs/28.2/lisp/org/ and /usr/share/emacs/site-lisp/elpa/org-9.4/)
    ```
    
    The former version `/usr/share/emacs/28.2/lisp/org/` has actually been installed via the Debian package `elpa-org`, which further depends on the package `org-mode`. From this we can see that `org-mode` has been integrated into Emacs itself instead of an external package.
    
    Solution
    
    -   Remove `/usr/share/emacs/site-lisp/elpa/org-9.4/`, which is obviously obsolete.
    -   Install the Debian package `elpa-org-contrib`, which contains `ox-freemind` and `ox-taskjuggler`. I have been using them to export Org mode contents to Freeplane mind map as well as TaskJuggler for project management. Both of them are enabled in the variable `org-export-backends`. The package `elpa-org-contrib` is installed to the folder `/usr/share/emacs/site-lisp/elpa/org-contrib-0.4`.
-   Each time when I export Org mode contents including LaTeX source code blocks, there will be an prompt about whether each of them should be executed.
    
    Solution: add the header arguments `:eval never-export :exports code` to the source code block will prevent such prompts.
-   CMake file cannot be automatically formatted by the package `cmake-format` anymore.
    
    ```text
    cmake-format errors:
    Traceback (most recent call last):
      File "/home/jihuan/.local/bin/cmake-format", line 5, in <module>
        from cmakelang.format.__main__ import main
    ModuleNotFoundError: No module named 'cmakelang'
    ```
    
    This is because the Emacs `cmake-format` package relies on the Python package `cmakelang`. However, Python has been upgraded from 3.7 to 3.11 during the system upgrade, which means all previously installed Python packages via `pip` should be reinstalled.


<a id="org7dd4b3a"></a>

## Python

As mentioned above, all Python packages should be reinstalled.

-   If there is a corresponding Debian package in `apt`, install that package system-wide.
    -   `cmake-format`
-   If there is no such as Debian package, create a virtual environment and install the package within it.


<a id="orgc835d28"></a>

## Jekyll

Cannot build blog anymore with the error:

```text
bundle: cannot execute: required file not found
```

The cause is after system upgrade, `ruby-rubygems` is upgraded from version 2.7 to 3.3.15 and all gems should be reinstalled.

-   `bundler`
-   `jekyll`
-   `minima`: blog style
-   `kramdown`: markdown support

```text
gem install bundler jekyll minima kramdown
```

Change to the folder of the blog, run `bundle install`.


<a id="org3ee59af"></a>

## Texlive based LaTeX

`ntheorem` does not work with `hyperref` anymore.

Solution: the package option `thref` for `ntheorem` should not be used.


<a id="org23d9778"></a>

## GNU Octave

Compatibility issue of `octave::interpreter::eval_string` related functions, when a function without return value is called from C++ via `libinterp`.


<a id="org7a5f4ff"></a>

## KDE Plasma desktop

The fast key &ldquo;Meta&rdquo; for triggering the Application launcher cannot be disabled in &ldquo;Shortcuts&rdquo;.

Solution: remove Application launcher applet and use &ldquo;Ctrl+mouse right button&rdquo; to trigger it when showing the desktop.


<a id="orgaaf499c"></a>

## PulseAudio

Debian Bookworm uses `pipewire` by default, which replaces previous `pulseaudio`.

If `pulseaudio` is needed, it can be switched back like this.

```text
systemctl unmask pulseaudio
systemctl --now disable pipewire-pulse
systemctl --now enable pulseaudio.service pulseaudio.socket
systemctl --user restart pulseaudio.service
```


<a id="org4f3d147"></a>

## Wacom tablet

When switching to my predefined fast keys for some applications such as `xournal`, there is the &ldquo;invalid offset&rdquo; error.

```text
Invalid offset into Wacom Button Actions property.
```

Cause: Button 9 on the Pen Stylus is not available on Debian Bookworm. This can be checked by executing

```text
xsetwacom -s get <device-id/device-full-name> all | grep Button
```

Solution: all settings related to Button 9 on the Pen Stylus should be removed from my Wacom scripts.

<a id="orgdb17c7c"></a>

## Video player

VLC and mplayer cannot play mkv or mp4. VLC reported the following error.

```text
VLC could not decode the format "h264" (H264 - MPEG-4 AVC (part10))
```

Solution: install the Debian package `mediastreamer2-plugin-openh264`.
