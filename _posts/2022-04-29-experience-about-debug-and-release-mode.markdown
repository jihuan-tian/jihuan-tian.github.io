---
layout: post
title: Experience about debug and release mode
date: 2022-04-29
categories: [computer]
tags: [programming,C++,算法开发]
mathjax: false
---

In this post, I'll summarize my experience and understanding about the debug mode and release mode when compiling C++ programs.

1. During the program development stage, the debug mode should be used. This is because assertions as an effective measure for defensive programming are only available in the debug mode, so that inherent errors and bugs can be detected or captured.
2. Even though the program can be successfully compiled in the debug mode, it still cannot ensure a successful compilation in the release mode. Even though the compilation in the release mode is successful, there may be some annoying warning messages, such as complains about unused variables. Therefore, the program compilation must be successful in both modes. Moreover, we had better make ensure there is not a single warning message produced.
3. Algorithms implementing the finite element method or boundary element method are computation intensive, which is quite time consuming during the verification stage where the debug mode should be used. To accelerate the debug and verification efficiency, we should always design a small test model with a mesh as coarse as possible. Sometimes, a model containing only a single cell or double cells is enough for a theoretical verification. In such simple or even degenerate circumstances, it is also feasible to solve the problem by manual computation, which can then be compared with the numerical simulation.
4. During the stage of performance profiling, we are interested in which lines of the source code are the bottleneck. If the program to be profiled is compiled in the release mode, due to compiler optimization, the generated machine code of the executable or library does not rigorously correspond with the source code. Therefore, it is recommended to use the debug mode for performance profiling.
5. After the program is theretically verified and its performance is tuned and optimized, it is the time for us to switch to the release mode and get its maximum speed.
