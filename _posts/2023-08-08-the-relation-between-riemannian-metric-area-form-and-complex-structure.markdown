---
layout: post
title: The relation between Riemannian metric, area form and complex structure
date: 2023-08-08
categories: [math]
tags: [differential-geometry,cmu-ddg,snippet]
mathjax: true
---

In the [CMU DDG course](https://youtu.be/FRvhgkGKfSM?list=PL9_jI1bdZmz0hIrNCMQW1YmZysAiIYSSS&t=3288), for an immersed surface defined by the map $$f $$ which is a vector-valued 0-form, the relation between Riemannian metric $$g $$, area form $$dA $$ and complex structure $$\mathcal{J} $$ is given as

$$
 g(X,Y) = dA(X, \mathcal{J}Y). 
$$

Here $$X $$ and $$Y $$ are vectors in the local coordinate chart assigned to the surface patch. $$g(\cdot,\cdot) $$ is a covariant rank-2 tensor, which returns the inner product of the two pushed forward vectors related to its two operands, i.e.

$$
 g(X, Y) = \left\langle df(X), df(Y) \right\rangle. 
$$

$$dA(\cdot,\cdot) $$ is the area form, which returns the absolute area of the parallelogram spanned by the two pushed forward vectors related to its two operands.

The complex structure $$\mathcal{J} $$ is defined as rotating the pushed forward vector by $$\frac{\pi}{2} $$ around the normal vector:

$$
 df(\mathcal{J}X) := N \times df(X). 
$$

According the rule for the wedge product of two vector-valued 1-forms, we have

$$
 \left( df \wedge df \right)(X, Y) = df(X)\times df(Y) - df(Y)\times df(X) = 2 df(X)\times df(Y) = 2 N dA(X, Y), 
$$

where $$N $$ is the unit normal vector.

Take inner product with respect to $$N $$ at both sides of the above equation, we have

$$
 \left\langle N, df(X) \times df(Y) \right\rangle = dA(X, Y). 
$$

Then the right hand side of the first equation becomes

$$
 \rhs = \left\langle N, df(X) \times df(\mathcal{J}Y) \right\rangle = \left\langle N, df(X) \times \left( N \times df(Y) \right) \right\rangle. 
$$

Using the mixed product identity $$a\cdot(b\times c) = b\cdot(c\times a) = -b\cdot(a\times c) $$, we have

$$
 \rhs = -\left\langle df(X), N\times(N\times df(Y)) \right\rangle. 
$$

Note that applying $$N\times $$ two times is equivalent to rotating the original pushed forward vector by $$\pi $$, hence

$$
 \rhs = -\left\langle df(X), -df(Y) \right\rangle = \left\langle df(X), df(Y) \right\rangle, 
$$

which is equal to the left hand side $$g(X,Y) $$ of the first equation.
