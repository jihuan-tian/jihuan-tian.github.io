---
layout: post
title: The purpose of a pure virtual function with a default implementation
date: 2024-03-05
categories: [computer]
tags: [programming,C++]
mathjax: false

---
-   A pure virtual function can have its implementation. But the implementation should be outside the class body.
-   In a derived class, the pure virtual function must be explicitly reimplemented. Otherwise, the child class will also be an abstract class.
-   If an implementation has been given in the parent class for the pure virtual function, it can be called from the child class as `Parent::foo()`.

Therefore, a pure virtual function with an implementation has two design purposes:

1.  The derived class, if not abstract, should has its own implementation of the virtual function.
2.  The provided implementation of the pure virtual function in the parent class can be used by derived classes as a common method.

{{ "2024-03-05-the-purpose-of-a-pure-virtual-function-with-a-default-implementation" | backlink }}
