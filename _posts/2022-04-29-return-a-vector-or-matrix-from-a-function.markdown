---
layout: post
title: Return a vector or matrix from a function
date: 2022-04-29
categories: [computer]
tags: [programming,C++,算法开发]
mathjax: false
---

There are usually two implementations for returning a vector or matrix from a function.

1. Returned as the function's return value

   In this case, the memory of the vector or matrix is dynamically allocated inside the function. When the function returns, the data will be copied to a temporary object as the function's return value. Usually, the compiler optimization will obviate such copying and directly returns the object.

   The advantage of this method is that the calling convention `obj=function_name(...)` is convenient and consistent with our habit about value assignment in mathematics. For the disadvantage, it is obvious that if such function is called many times, the vector or matrix object will be dynamically created for the same number of times, which requires additional overheads.

2. Returned as an argument of the function with an `output` intent

   The vector or matrix object is passed by reference into the function, and its memory should be allocated before the function call. Hence, there is no internal dynamic memory allocation inside the function anymore. Even though we may not be so familiar with the calling convention here `function_name(..., returned_object)`, we can get used to it by practice and the advantage is obvious. If the memory for the fixed-size vector or matrix has been pre-allocated outside the function, it can be reused by the function and the time for dynamic memory allocation is saved. If the function is called many times, the performance improvement will be manifest. This also reminds us not to reinitialize the vector or matrix and reallocate memory for it inside the function.
