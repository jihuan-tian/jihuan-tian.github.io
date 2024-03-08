---
layout: post
title: Performance of LAPACK and its parallelism
date: 2023-12-16
categories: [computer]
tags: [LAPACK,HPC]
mathjax: true
---

-   LAPACK was originally targeted to achieve good performance on **single-processor vector machines** and on **shared memory multiprocessor machines** with a modest number of powerful processors.
-   Vectorization in linear algebra algorithms cannot be implemented in Fortran 77, because its compiler cannot minimize the number of memory references, i.e. the number of vector load and store operations.
-   Data movement between different levels of machine memory limits the performance of vector or scalar floating point computations. Typical types of data movement include
    
    -   Transfer of vector operands in and out of **vector registers**
    -   Transfer of scalar operands in and out of a **high speed scalar processor**
    -   Movement of data between **main memory** and **high speed cache** or **local memory**
    -   **Paging** between actual memory and disk storage in a **virtual memory system**
    
    **The key philosophy is to reuse data as much as possible, while it is stored in the higher levels of the memory hierarchy.** Here, the so-called **higher levels** means memory access is faster there.
-   Principal type of parallelism exploited by LAPACK: nested loop-based parallelism.
-   LAPACK relies on BLAS as its building blocks for portability. BLAS is the low-level interface between LAPACK and different machine architectures. Hence, the efficiency of LAPACK depends on the implementation of BLAS.
-   Different levels of operations in BLAS
    
    -   Level 1: vector operations, such as $$y \leftarrow \alpha x + y$$, which cannot achieve high efficiency on most modern supercomputers. However, they comprise only a insignificant fraction in a typical linear algebra computation task.
    -   Level 2: matrix-vector operations, such as $$y \leftarrow \alpha Ax + \beta y$$. On computers with one more levels of cache, such as PC, RISC workstation, the performance is limited by the rate of data movement between different levels of memory.
    -   Level 3: matrix-matrix operations, such as $$C \leftarrow \alpha AB + \beta C$$. The data movement issues in Level 2 is solved in this level and $$O(n^3)$$ floating-point operations can be achieved o1n $$O(n^2)$$ data.
    
    *Therefore, LAPACK itself can run in parallel. Compared to the high level task based parallelism provided by TBB, this is a parallelism at the kernel function level.*
-   More complicated linear algebra algorithms such as Cholesky and LU factorization are implemented as **block algorithms** by LAPACK to achieve the highest performance which is commensurate with the peak performance for matrix-matrix multiplication, i.e. BLAS level 3.
