---
layout: post
title: Definitive solution for Eclipse indexer getting stuck
date: 2023-06-28
categories: [computer]
tags: [Eclipse]
mathjax: true
---

When I work on CUDA C++ project in Eclipse, the indexer often gets stuck in two situations:

1.  when it parses a `*.hcu` file;
2.  it hangs with the message "waiting for exclusive index access".

Before solving the indexer problem, make sure all necessary include paths have been added to Eclipse's project settings, i.e. `Project Properties` \(\rightarrow \) `Paths and Symbols` \(\rightarrow \) `Includes`. Even though some user defined include paths in the project have been correctly setup in `CMakeLists.txt`, for example, in my BEM project, I have defined

```cmake
INCLUDE_DIRECTORIES(${CMAKE_SOURCE_DIR}/include)
```

this path cannot be recognized by Eclipse, which should be manually added to the project settings.

For the first issue, I have verified that a successful solution is to separate the source code indexing into two stages: 1. index those pure C++ files, 2. index CUDA files. The detailed procedures are:

1.  Close Eclipse.
2.  Remove all CUDA files, i.e. `*.hcu` files or even `*.cu` files, from the project.
3.  Go to the folder `$workspace/.metadata/.plugins/org.eclipse.cdt.core/` (where `$workspace` is the Eclipse workspace folder), delete the project's `pdom` file. *This step only ensures that everything starts anew, which is optional.*
4.  Restart Eclipse and let the indexer rebuild the index. Because there are no CUDA source code in the project, the indexer should finish in a short time.
5.  Close Eclipse.
6.  Move back CUDA `*.hcu` and `*.cu` files into the project.
7.  Restart Eclipse.
8.  Right click on the project name in the Project Explorer, select `Index` \( \rightarrow \) `Search for Unresolved Includes`. This will list all those unresolved header files in the `Search` panel.
9.  To let the indexer process these just added `*.hcu` files, select `Index` \( \rightarrow \) `Update with Modified Files`. We can see that Eclipse treats these newly added files as "Modified Files". N.B. Do not select `Index` \( \rightarrow \) `Re-resolve Unresolved Includes`, which does not work.

For the second situation that the indexer "waiting for exclusive index access", close all opened editors will release locks on those files and the indexer should continue its work.

If the problem is still unsolved, restart Eclipse may help. If the problem is still unsolved, try these solutions several times with patience.
