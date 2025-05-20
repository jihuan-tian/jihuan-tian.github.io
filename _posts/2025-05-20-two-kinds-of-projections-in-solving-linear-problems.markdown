---
layout: post
title: Two kinds of projections in solving linear problems
date: 2025-05-20
categories: [math]
tags: [linear-algebra,PDE]
mathjax: false
---

There are two kinds of projection when we solve a linear problem, either finite dimensional or infinite dimensional, which are used for **solution representation** and **error measurement**. They are important in the Petrov-Galerkin method.

Projecting the solution vector or function to a **trial space** (also called ansatz space) is a very important concept. In this way, we can search the solution in a smaller finite dimensional space than the original larger finite dimensional space (e.g. linear algebra, and in this case the trial space is actually an affine space rooted at the initial guess $$x_0 $$ of the solution) or even infinite dimensional space (e.g. PDE). Such a projection is actually a linear expansion or **representation** of the solution vector, therefore a basis should be selected.

With an initial guess or intermediate approximant, there is an error or residual vector/function between the current solution and the true solution (still unknown). Then the error or residual vector should be projected to another also small finite dimensional space called **test space**. The projected error will be constrained to zero. Such a projection can be considered as a **measurement** of the error vector. A basis should be selected for the test space which plays the role of a set of rulers in different dimensions. When these rulers all register zeros (usually we only require them to be less than a threshold value $$\varepsilon \ll 1 $$), we reckon that the error has been reduced to zero and treat the current solution as the best approximant to the true solution. Of course, if a different test space is adopted, the projected error vector may not satisfy the constraints anymore and the solver should continue until the convergence is achieved.

When the two projection spaces are the same, we obtain the familiar Galerkin method. When they are different, we have the more general Petrov-Galerkin method.

{{ "2025-05-20-two-kinds-of-projections-in-solving-linear-problems" | backlink }}
