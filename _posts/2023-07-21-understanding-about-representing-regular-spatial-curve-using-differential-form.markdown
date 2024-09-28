---
layout: post
title: Understanding about representing regular spatial curve using differential form
date: 2023-07-21
categories: [math]
tags: [differential-geometry,cmu-ddg,snippet]
mathjax: true
---

- A spatial curve is represented as a vector-valued 0-form
    $$\gamma(s)$$.

- The tangent vector of the curve is not the 1-form $$d\gamma$$ but
  the application of this 1-form to the basis
  $$\frac{\pdiff }{\pdiff s}$$. N.B. For a vector-valued 1-form, its
  application to a vector is not a scalar but a vector.

- When we represent the tangent vectors of a curve using differential
  form, it is obvious that if $$d\gamma$$ is zero at a point $$s_0$$,
  then $$d\gamma(\frac{\pdiff }{\pdiff s})\vert_{s_0}$$ is always a
  zero vector. This means the tangent vector at $$s_0$$ cannot be well
  defined via a differential form, even though a tangent vector
  geometrically exists. This is why the definition of a regular curve
  requires $$d\gamma\neq 0$$ everywhere on the curve.

{{ 2023-07-21-understanding-about-representing-regular-spatial-curve-using-differential-form | backlink }}
