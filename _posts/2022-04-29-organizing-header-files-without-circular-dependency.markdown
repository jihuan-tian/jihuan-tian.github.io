---
layout: post
title: Organizing header files without circular dependency
date: 2022-04-29
categories: [computer]
tags: [programming,C++,算法开发]
mathjax: false
---

As a C++ project becomes larger, the probability of stumbling across circularly dependent header files increases. This problem can usually be solved by the technique of forward declaration, where the dependency between two header files is only allowed for pointer types.

The following example shows circularly dependent two header files `a.h` and `b.h`.

```c++
//! File: a.h
#ifndef A_H
#define A_H

#include "b.h"

Class A
{
public:
  B b;
};

#endif
```

```c++
//! File b.h
#ifndef B_H
#define B_H

#include "a.h"

class B
{
public:
  A *a;
};

#endif
```

The file `b.h` can be modified as below to remove the circular dependency.

```c++
//! File b.h
#ifndef B_H
#define B_H

class A;

class B
{
public:
  A *a;
};

#endif
```

Even though the forward declaration can suppress compiler errors, the lone declaration `class A;` at the front of `b.h` still indicates a premature or imperfect design. Therefore, we had better avoid such scenario after careful consideration and several rounds of restructuring of the functional modules.

At the beginning of the project, there may be not enough tangible materials, including code, pseudocode, notes, derivations, etc. Hence, a detailed and feasible overall design of the function modules is unrealistic. However, as the project goes on, we gradually form an overall picture of the functional modules and accumulate enough information to perform a scanning of the `#include` directives in all the header files. Then a directed graph can be drawn for illustrating their dependencies.

To resolve those circular dependencies, we need to decompose large header files into functional atoms. This is because the mutual dependency of two header files can never be an absolute 100% dependency. Such dependency must have concentrated on a quite limited number of points, such as some class declarations or shared data structures. Therefore, separate each of them into an independent file will for sure solve the problem.

{{ 2022-04-29-organizing-header-files-without-circular-dependency | backlink }}
