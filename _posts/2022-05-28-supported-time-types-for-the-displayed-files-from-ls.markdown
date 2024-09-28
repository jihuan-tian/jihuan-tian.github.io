---
layout: post
title: Supported time types for the displayed files from ls
date: 2022-05-28
categories: [computer]
tags: [Linux,command]
mathjax: false
---

Three types of time are supported for files stored on Linux, which can be accessed via the `ls` command.

-   `mtime`: time of last modification of file contents. When `ls -l` is called, this is displayed by default. Possible options for `ls` are as follows.
    -   `-t`: do not show time and sort by `mtime`.
    -   `-l`: show `mtime` and sort by file name.
    -   `-l -t`: show `mtime` and sort by `mtime`.
-   `atime`: file access time.
    -   `-u`: do not show time and sort by `atime`.
    -   `-l -u`: show `atime` and sort by file name.
    -   `-l -t -u`: show `atime` and sort by `atime`.
-   `ctime`: time of last modification of file status information.
    -   `-c`: do not show time and sort by `ctime`.
    -   `-l -c`: show `ctime` and sort by file name.
    -   `-l -t -c`: show `ctime` and sort by `ctime`.

Furthermore, if the option `--full-time` is present, the full-ISO format of the date and time will be displayed.

{{ 2022-05-28-supported-time-types-for-the-displayed-files-from-ls | backlink }}
