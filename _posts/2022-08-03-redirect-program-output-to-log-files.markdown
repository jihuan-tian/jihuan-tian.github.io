---
layout: post
title: Redirect program output to log files
date: 2022-08-03
categories: [computer]
tags: [Bash,command]
mathjax: false
---

When we perform batch tests on developed algorithms, it is helpful to save the messages and data printed out by the program to a log file for backup and further analysis, while still keeping them displayed in the console for real time monitoring. This can be achieved via output redirection on Linux.

We know that the standard file descriptors on Linux are:

1.  Standard input: 0
2.  Standard output: 1
3.  Standard error: 2

If using Octave, we can get them by calling `stdin`, `stdout` and `stderr`. In C++, they are `std::cin`, `std::cout` and `std::cerr` respectively. If we execute an Octave script directly from the console instead of in a session, the following ways can be used.

1.  Standard output and standard error directed to a same file without being displayed in the console.
    
    ```bash
    $ octave script_name.m &> logfile.log
    ```
    
    `&>` means `1>logfile.log 2>logfile.log` but with `logfile.log` opened only once.

2.  Standard output and standard error directed to different files without being displayed in the console.
    
    ```bash
    $ octave script_name.m > logfile.log 2> logfile.err
    ```
    
    `> logfile.log` is short for `1>logfile.log`.

3.  If both console message display and log file record are needed, the command `tee` should be used.
    
    ```bash
    $ octave script_name.m 2>&1 | tee logfile.log &
    ```
    
    `2>&1` redirects the standard error to the standard output.

{{ 2022-08-03-redirect-program-output-to-log-files | backlink }}
