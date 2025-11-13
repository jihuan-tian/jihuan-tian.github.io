---
layout: post
title: Symmetric $\mathcal{H}$-matrix
date: 2025-11-13
categories: [math]
tags: [BEM]
mathjax: true
---

In BEM, an $$\mathcal{H}$$-matrix $$\mathcal{V} $$ is a discretization of a bilinear form $$b_V $$. The bilinear form $$b_V $$ is induced from a boundary integral operator $$V: X \rightarrow Y $$. The boundary integral operator is further determined by a kernel function $$\kappa(x,y) $$, which depends on two coordinate variables, $$x $$ for the field point and $$y $$ for the source point in $$\mathbb{R}^d $$. The discretization of the bilinear form $$b_V $$ needs to choose two finite dimensional function spaces: domain space $$X_h $$ and the dual space $$Y_h' $$ of the range space $$Y_h $$ of the boundary integral operator. The former is the trial space and the latter is the test space.

Therefore, the symmetry of the $$\mathcal{H}$$-matrix $$\mathcal{V} $$ depends on

1.  if the kernel function is symmetric, i.e. $$\kappa(x,y) == \kappa(y,x) $$ and
2.  if the two function spaces $$X_h $$ and $$Y_h' $$ are symmetric, i.e. $$X_h == Y_h' $$.

The kernel function symmetry determines the value symmetry and the function space symmetry determines the structure symmetry of the $$\mathcal{H}$$-matrix.

{{ "2025-11-13-symmetric-hmatrix" | backlink }}
