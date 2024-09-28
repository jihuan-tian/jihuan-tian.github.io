---
layout: post
title: Install and start Steam on Debian Linux
date: 2024-04-06
categories: [computer]
tags: [游戏]
mathjax: false
---

1.  Download and install the `deb` file from Steam&rsquo;s official website.
2.  After installation of the `deb` file and start steam, it says some additional packages (most of them are i386 related) should be installed. Confirm and proceed, steam will start normally. However, for the next run, it still complains lacking those packages. Actually, these packages should be manually installed via `apt-get` or `aptitude`.
3.  Because I&rsquo;m using 4K monitor, to enable high DPI support, steam should be started with the command line option `-forcedesktopscaling` according to [here](https://www.dedoimedo.com/computers/steam-linux-4k-scaling.html). For example,
    
    ```text
    /usr/bin/steam -forcedesktopscaling=2 %U
    ```
    
    Using `kmenuedit`, the item for steam in the start menu can be modified accordingly.

{{ 2024-04-06-install-and-start-steam-on-debian-linux | backlink }}
