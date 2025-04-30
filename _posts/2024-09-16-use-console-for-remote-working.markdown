---
layout: post
title: Use console for remote working
date: 2025-04-30
categories: [computer]
tags: [remote-working]
mathjax: false
---

-   Misaligned Chinese characters
    
    **Phenomenon** When I travel outside and continue my personal project development, I will connect to my home server via SSH and use Emacs in text mode, because the unstable network connection and slow speed cannot ensure smooth GUI usage. If KDE Konsole is used and there are Chinese characters in the buffer, the text will be misaligned. I&rsquo;ve confirmed that the environment variable `TERM` is `xterm-256color` and the character encoding is UTF-8. However, this does not solve the issue.
    
    **Solution** Use `gnome-terminal` instead of KDE Konsole.
-   Font face colors cannot be displayed within GNU `screen`
    
    I&rsquo;ve tried to configure the terminal type and enable true color in `~/.screenrc` as below, but it is of no use.
    
    ```text
    truecolor on
    term screen-256color
    allowtruecolor on
    ```
    
    **Solution** Use `tmux` instead of `screen`. Configuration of `tmux` in `~/.tmux.conf`
    
    1.  Use `C-z` as the prefix key.
    2.  Disable the status line.
        
        ```text
        set-option -g prefix C-z
        unbind-key C-b
        bind-key C-z send-prefix
        set-option -g status off
        ```

{{ "2024-09-16-use-console-for-remote-working" | backlink }}
