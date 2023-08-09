---
layout: post
title: Understanding about the coboundary of coboundary is empty
date: 2023-07-14
categories: [math]
tags: [differential-geometry,cmu-ddg,snippet]
mathjax: true
---

According to (Desbrun, Kanso, and Tong 2008), the exterior derivative
operator $$d$$ is the adjoint of the boundary operator $$\partial$$.
This is based on the Stokes’ theorem. Let $$\omega$$ be a $$k$$-form and
$$\sigma$$ be a simplicial chain. Then we have


$$
\int_{\sigma} d\omega = \int_{\partial\sigma} \omega.
$$

This can be
rewritten as
$$\left[ d\omega, \sigma \right] = \left[ \omega, \partial\sigma \right]$$,
where the brackets $$[\cdot,\cdot]$$ group two entities comprising a
differential form and a simplicial chain via integration. And the
integration is also a linear operator. According to the concept of
adjoint operator in functional analysis, $$d$$ is the adjoint of
$$\partial$$.

We already know that the boundary of boundary is an empty set, i.e.
$$\partial \circ \partial = \emptyset$$. Then we have


$$
\left[ \omega, \partial\circ\partial\sigma \right] = \left[ d\omega, \partial\sigma \right] = \left[ d\circ d\omega, \sigma \right] \equiv 0.
$$


This just brings about the exactness of the exterior derivative
operator, which means the coboundary of coboundary also vanishes.

<div id="refs" class="references hanging-indent">

<div id="ref-DesbrunDiscrete2008" markdown="1">

Desbrun, Mathieu, Eva Kanso, and Yiying Tong. 2008. “Discrete
Differential Forms for Computational Modeling.” In *Discrete
Differential Geometry*, edited by Alexander I. Bobenko, John M.
Sullivan, Peter Schröder, and Günter M. Ziegler, 287–324. Oberwolfach
Seminars. Basel: Birkhäuser.
<https://doi.org/10.1007/978-3-7643-8621-4_16>.

</div>

</div>
