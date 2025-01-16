---
layout: post
title: Migrate from Emacs 28.2 to 29.4
date: 2025-01-16
categories: [computer]
tags: [Emacs]
mathjax: false
---

-   Refer to [Install Emacs](https://www.gnu.org/software/emacs/manual/html_node/efaq/Installing-Emacs.html) and download Emacs from [here](http://ftpmirror.gnu.org/emacs/).
-   Configure and compile
    
    ```text
    ./configure --with-native-compilation --with-x-toolkit=lucid --with-tree-sitter --with-wide-int --with-json --with-modules --without-dbus --with-gnutls --with-mailutils --without-pop --with-cairo --with-imagemagick CFLAGS="-O2 -pipe -mtune=native -march=native -fomit-frame-pointer"
    ```
    
    Initially, I used the option `--with-pgtk --with-x-toolkit=gtk3`. However, the compiled Emacs intermittently crashed with the following error. Therefore, I finally resorted to the option `--with-x-toolkit=lucid`.
    
    ```text
    The program 'emacs' received an X Window System error.
    This probably reflects a bug in the program.
    The error was 'BadMatch (invalid parameter attributes)'.
      (Details: serial 23499 error_code 8 request_code 18 (core protocol) minor_code 0)
      (Note to programmers: normally, X errors are reported asynchronously;
       that is, you will receive the error a while after causing it.
       To debug your program, run it with the GDK_SYNCHRONIZE environment
       variable to change this behavior. You can then get a meaningful
       backtrace from your debugger if you break on the gdk_x_error() function.)
    ```

-   Because I&rsquo;m migrating from Emacs 28.2 in Debian Bookworm to Emacs 29.4, after the installation, some packages need to be manually reinstalled or required.
    -   Add `(require 'recentf)` to `.emacs`.
    -   `helm-recentf` was previously bound to `C-x C-r`. In Emacs 29.4, `helm` is not installed, so I replace `helm-recentf` with `recentf-open`.
    -   Install the `session` package from ELPA, then the previous configuration `(add-hook 'after-init-hook 'session-initialize)` in `.emacs` will work.
    -   Add the path of previously installed ELPA packages `pyim` and `pyim-wbdict` to `load-path`:
        
        ```elisp
        (add-to-list 'load-path "~/.emacs.d/elpa/pyim-wbdict-20220604.1340")
        (add-to-list 'load-path "~/.emacs.d/elpa/pyim-20240508.256")
        ```
    -   Remove `(require 'org-install)`, `(require 'ox-freemind)`, `(require 'ox-taskjuggler)` from `tjh-org.el`. They are not available in the `org` packaged with Emacs 29.4.

{{ "2025-01-16-migrate-from-emacs-28.2-to-29.4" | backlink }}
