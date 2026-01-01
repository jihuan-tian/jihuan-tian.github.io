---
layout: post
title: Clarification of the big-five
date: 2026-01-01
categories: [computer]
tags: [C++]
mathjax: false
---

The big-five refers to five special member functions of a class, i.e. destructor, copy constructor, copy assignment operator, move constructor, move assignment operator. They are responsible for resource creation, copy, "stealing" and release. Following the rule of the big-five, we should define all of them if any of them is declared in a class.

By default, the compiler will generate six member functions, i.e. the default constructor and the big-five. In the following cases, generation of these six member functions will be suppressed.

-   If we declare any constructor (including the copy constructor) for the class, the compiler will not generate the default constructor.
-   The compiler will always generate a destructor if we do not declare our own.
-   If we declare a copy constructor, copy assignment operator, move constructor, move assignment operator or destructor, move constructor and move assignment operator will not be generated.
-   If we declare a move constructor or move assignment operator, copy constructor and copy assignment operator will not be generated.
-   If we declare a copy constructor or destructor, the copy assignment operator will be deprecated.
-   If we declare a copy assignment operator or destructor, the copy constructor will be deprecated.
-   When there are reference variables as class members, because they cannot be moved, the compiler will not generate a move constructor or move assignment operator.

The above rules are summarized into the following table.

![img](/figures/2026-01-01-big-five.png)

{{ "2026-01-01-clarification-of-the-big-five" | backlink }}
