---
layout: post
title: Algorithm for reconstruction of a discrete space curve
date: 2023-07-21
categories: [math]
tags: [differential-geometry,cmu-ddg,snippet]
mathjax: true
---

The algorithm given in the CMU’s discrete differential geometry course
[Lecture 11](https://youtu.be/IyJnd_LvGRI?list=PL9_jI1bdZmz0hIrNCMQW1YmZysAiIYSSS&t=2349)
only illustrates the basic concept of the workflow for reconstruction of
a discrete space curve, which cannot be directly used. Therefore, I
recapitulate the algorithm here.

Assume there are $$M$$ vertices
$$\left\{ v_0, \cdots, v_{M-1} \right\}$$. Then there are $$M-1$$
piecewise linear edges $$\left\{ e_0, \cdots, e_{M-2} \right\}$$ with
the edge length $$\left\{ l_{01}, \cdots, l_{M-2,M-1} \right\}$$. The
corresponding tangent vectors along the edges are
$$\left\{ T_{01},\cdots,T_{M-2,M-1} \right\}$$.

Curvature $$\kappa_i$$ is defined as the angle variation of the two
consecutive edges $$e_{i-1}$$ and $$e_{i}$$ sharing the $$i$$-th vertex.
Hence there are no curvatures defined at the starting and ending
vertices. The array of curvatures are
$$\left\{ \kappa_1, \cdots, \kappa_{M-2} \right\}$$.

The two consecutive edges $$e_{i-1}$$ and $$e_i$$ are coplanar. The
normal vector of the corresponding plane is the binormal vector $$B_i$$.
There are $$M-2$$ number of such binormal vectors
$$\left\{ B_1,\cdots,B_{M-2} \right\}$$, which can be considered as
associated with the interior vertices.

For two consecutive binormal vectors $$B_i$$ and $$B_j$$, their
associated planes may not be parallel. Hence the angle change
$$\tau_{ij}$$ from $$B_i$$ to $$B_j$$ is not zero and this is just the
torsion. The array of torsion is
$$\left\{ \tau_{12}, \cdots, \tau_{M-3,M-2} \right\}$$.

With the above definitions and array sizes clarified, the algorithm for
reconstruction of a discrete space curve is given below.

![img](/figures/2023-07-21-algorithm-reconstruct-discrete-space-curve.png)

{{ 2023-07-21-algorithm-for-reconstruction-of-a-discrete-space-curve | backlink }}
