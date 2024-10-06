---
layout: post
title: Riemannian metric for a submanifold within \(\mathbb{R}^N\)
date: 2024-10-06
categories: [math]
tags: [differential-geometry]
mathjax: true
---

**Abstract** The Riemannian metric for a submanifold embedded in a Cartesian space with a higher dimension can be induced from the Riemannian metric for the Cartesian space by pulling it back with respect to the corresponding inclusion map of the submanifold.

The Riemannian metric is defined as a second order covariant tensor, not a 2-form (which is a second order anti-symmetric covariant tensor). Taking $$\mathbb{R}^3 $$ as example, the Riemannian metric is

$$
\begin{equation}
  ds^2 = dx^2+dy^2+dz^2 = dx\otimes dx + dy\otimes dy + dz\otimes dz.
\end{equation}
$$

Even though the concept of pull back is initially introduced for differential forms in Frankel's book "The Geometry of Physics", its properties still apply to covariant tensors such as the Riemannian metric, because a covariant tensor merely loses the anti-symmetry of a differential form, while the coordinate transformation and other properties are still preserved. If we assign a local coordinate chart $$(x,y) $$ to a submanifold $$M^2 $$ embedded in $$\mathbb{R}^3 $$ and assume the coordinate $$z$$ can be differentiably represented by $$x$$ and $$y$$ as $$z=z(x,y) $$, an inclusion map $$i: M^2 \rightarrow \mathbb{R}^3 $$ can be defined as $$(x,y) \rightarrow (x,y,z(x,y)) $$. Then we want to pull back the Riemannian metric from $$\mathbb{R}^3 $$ to $$M^2 $$ with respect to $$i$$.

Because the pull back operation is algebraically homeomorphic with respect to the wedge product $$\wedge $$, it is also algebraically homeomorphic with respect to the tensor product $$\otimes $$. Therefore,

$$
\begin{equation}
  i^{*}(dx^2) = i^{*}(dx\otimes dx) = i^{*}(dx)\otimes i^{*}(dx),
\end{equation}
$$

where $$i^{\ast}(dx) = \frac{\partial x}{\partial x} dx + \frac{\partial x}{\partial y} dy = dx$$. Hence

$$
\begin{equation}
  i^{*}(dx^2) = dx^2.
\end{equation}
$$

Similarly, $$i^{\ast}(dy^2) = dy^2 $$. Because $$i^{\ast}(dz) = \frac{\partial z}{\partial x} dx + \frac{\partial z}{\partial y} dy $$,

$$
\begin{equation}
  \begin{aligned}
    i^{\ast}(dz^2) &= \left( \frac{\partial z}{\partial x} dx + \frac{\partial z}{\partial y} dy \right) \otimes \left( \frac{\partial z}{\partial x} dx + \frac{\partial z}{\partial y} dy \right) \\
    &= \left( \frac{\partial z}{\partial x} \right)^2 dx^2 + \left( \frac{\partial z}{\partial y} \right)^2 dy^2 + 2 \frac{\partial z}{\partial x} \frac{\partial z}{\partial y} dxdy.
  \end{aligned}
\end{equation}
$$

Finally,

$$
\begin{equation}
  \begin{aligned}
    i^{\ast}(ds^2) &= dx^2 + dy^2 + \left( \frac{\partial z}{\partial x} \right)^2 dx^2 +
  \left( \frac{\partial z}{\partial y} \right)^2 dy^2 + 2 \frac{\partial z}{\partial x}
  \frac{\partial z}{\partial y} dxdy \\
    &= \left( 1 + \left( \frac{\partial z}{\partial x} \right)^2 \right)dx^2 + \left( 1 + \left( \frac{\partial z}{\partial y} \right)^2 \right) dy^2 + 2 \frac{\partial z}{\partial x} \frac{\partial z}{\partial y} dxdy.
  \end{aligned}
\end{equation}
$$
