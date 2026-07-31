---
layout: post
title: General workflow for debugging numerical libraries
date: 2026-07-31
categories: [thoughts]
tags: [programming]
mathjax: false
---

With some experience acquired from my development of HierBEM, I think the following procedure is suitable for debugging numerical libraries. At least, it works for me.

1.  Switch to the debug build type so the program will **stop as early as possible** when an error or exception occurs. In the release build type, some kinds of errors, such as division-by-zero, will not pop up and it can only be indirectly captured in a downstream stage, such as an iterative solver, where the introduced `nan` value leads to non-convergence.
2.  Let the program in the debug mode run freely for the first time within gdb. When gdb stops due to an error, record program status or print out variable values at the problematic stack.
3.  Without exiting the gdb session, set conditional break points based on the recorded variables and rerun the program.
4.  When gdb stops for the second time, manually print out data in gdb or write scaffold code to log more data. Writing Python scripts to print out values for some data types in gdb is also useful.

{{ "2026-07-31-general-workflow-for-debugging-numerical-libraries" | backlink }}
