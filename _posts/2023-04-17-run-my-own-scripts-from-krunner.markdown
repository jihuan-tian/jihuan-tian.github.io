---
layout: post
title: Run my own scripts from KRunner
date: 2023-04-17
categories: [computer]
tags: [KDE]
mathjax: false
---

KRunner provides a fast way for us to interact with Linux and KDE environment by simply pressing `Alt+Space` to run a bunch of functionalities, such as

-   installed applications
-   saved bookmarks
-   simple calculator
-   command line
-   desktop search
-   common places defined on the system
-   search engines
-   unit converter
-   list and switch windows

My personal scripts are placed in the folder `/usr/local/bin/scripts`, which has been added to the `PATH` environment variable. Although I can run these scripts directly from a console, they are still not accessible in KRunner. To solve this problem, these scripts should be manually added to the menu of KDE application launchers by running `kmenuedit`.

![img](/figures/2023-04-17_05-31-07-kmenuedit.png)
