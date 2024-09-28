---
layout: post
title: Ensure a safe and correct CMake build
date: 2024-09-22
categories: [computer]
tags: [CMake]
mathjax: false
---

If configuration or Makefile generation has been executed in the build folder of our CMake based project, there will be `CMakeCache.txt` files left there, which contain automatically generated CMake variables. If some external libraries required by our project have updates or the installation of them changes due to test purpose, CMake configuration and generation should be run again for our project.

However, for those automatically generated CMake variables, CMake configuration will not update their values. Therefore, to safely and correctly build our project, we had better firstly remove `CMakeCache.txt` and run `make clean` in the builder folder. Or we delete everything in this folder, then continue the configuration, generation and build trilogy.

{{ "2024-09-22-ensure-a-safe-and-correct-cmake-build" | backlink }}
