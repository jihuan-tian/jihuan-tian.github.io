---
layout: post
title: Find the real cause of program errors
date: 2026-07-10
categories: [thoughts]
tags: [programming]
mathjax: false
---

Usually a complicated numerical software library plays the role of a magnifier on any possible flaw or error in its implementation. Even though the error is conspicuous, it is usually impossible to directly find its cause, because the error and cause may be far apart, which is out of our expectation or prior knowledge. Then single stepping in a debugger does not help, since it only touches scattered factors which are unrelated to the error. An effective way is to list key technical stages in the program. Then we write some scaffold code to export internal data. It is these data which will probably reveal the route to the real cause.

![img](/figures/2026-07-02-19-46-15-program-debug-and-error-analysis_export.png)

{{ "2026-07-10-find-the-real-cause-of-program-errors" | backlink }}
