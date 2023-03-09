---
layout: post
title: Inspect large variables in Eclipse GDB
date: 2023-03-09
categories: [computer]
tags: [GDB,Eclipse]
mathjax: false
---

Eclipse is my workhorse for developing numerical libraries. Because debugging a boundary element method (BEM) algorithm usually involves large vectors or matrices, the debugger (`GDB`) called by Eclipse will frequently crash, which prevents me from further investigating into the inner code.

According to the documentation of GDB, for printing the value of a variable involving a large dynamically allocated memory, configure the variable `max-value-size` in the file `~/.gdbinit` ([reference](https://sourceware.org/gdb/current/onlinedocs/gdb/Value-Sizes.html)).

    (gdb) set max-value-size bytes
    (gdb) set max-value-size unlimited

However, the above configuration is not honoured by Eclipse by default, even after I set it in its preferences: `C/C++` → `Debug` → `GDB` → `GDB command file`.

According to Eclipse documentation on `GDB command file`:

> Specifies the GDB debugger command file that will be used by default for each newly created debug launch. This can be useful if you often/always want to use a GDB command file for your launches. Each launch configuration allows to override this setting in the Debugger tab.

we know that the configuration for debug launch of each executable may override the setting in `GDB command file`. After checking the Debugger setting for my tester, I found out it only specified `.gdbinit` in the working directory as the command file instead of the one in my home directory `~/.gdbinit`.
