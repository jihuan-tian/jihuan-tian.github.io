---
layout: post
title: Defensive programming
date: 2022-09-15
categories: [computer]
tags: [programming]
mathjax: false
---

Defensive programming is a programming style or convention that a set of a priori knowledge and constraints both explicitly and implicitly possessed by the objects, functions, etc. should be explicitly be verified or **asserted** based on the preprocessing and compiling process of the compiler. Therefore, defensive programming can be considered as an a priori test, while unit test is posteriori. Both of them ensure the safety of variable type, data objects and the results of general and mathematical logic.

Common techniques in C++ include:

-   Maintain the constness of member functions and objects.
-   Use C++20 concepts as constraints.
-   Verify if matrix/matrix or matrix/vector sizes match.
-   Check the identity between two equivalent objects.
-   Ensure the value of a variable is in the expected range.

{{ "2022-09-15-defensive-programming" | backlink }}
