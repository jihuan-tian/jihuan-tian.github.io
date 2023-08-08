---
layout: post
title: The meaning of Jacobian matrix having a rank \(r\)
date: 2023-07-05
categories: [math]
tags: [differential-geometry,cmu-ddg,snippet]
mathjax: true
---

Let $$F(x) = 0$$ be a set of $$r$$ constraint functions defining a
locus, where $$x\in \mathbb{R}^{r+n}$$. If the Jacobian matrix of the
multi-dimensional map $$F$$ has rank $$r$$, it means all the constraint
equations are effective or independent, and $$r$$ coordinate components
in $$x$$ can be eliminated, i.e. represented by the other $$n$$
coordinate components. Hence, the locus or submanifold defined by
$$F(x) = 0$$ has $$n$$ dimensions.

Here we should bear in mind that **the rank of the Jacobian matrix is
actually the number of the constraints instead of the number of free
variables or dimensions of the submanifold**. Hence, the submanifold
dimension is the co-dimension of $$r$$ in $$\mathbb{R}^{r+n}$$, i.e.
$$n$$.
