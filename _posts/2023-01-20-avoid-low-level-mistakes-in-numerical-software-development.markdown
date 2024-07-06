---
layout: post
title: Avoid low-level mistakes in numerical software development
date: 2023-01-20
categories: [thoughts]
tags: [算法开发]
mathjax: false
---

During numerical software development, it is relatively easy for us to successfully compile the source code. With additional effort and meticulocity, the compilation can also be made free of warnings. However, even with such careful self-control, there could still be &ldquo;weird&rdquo; error messages jumping out unexpectedly, which are quite often caused by our low-level mistakes.

According to my development experience, besides checking the theoretical derivation and source code, paying attention to the following points may provide some help to this situation.

-   Check always means double check at least.
-   Check the **validity** and **consistency** of input parameters or data files. **Consistency** is crucial when we compare the results from theoretical analysis, symbolic math derivation, numerical verification using scripting language (Octave, Python, etc.), numerical computation using our own code, third party simulation software.
-   Check if the currently edited source file is the correct local copy or has the correct Git version and branch.
-   Check if the working path, path to input files and path to output files are what we have expected.
-   Check the validity of the command line arguments.
-   Check typos in variable types and names. Since we often copy and paste from existing code snippet during programming, we are prone to make errors .
