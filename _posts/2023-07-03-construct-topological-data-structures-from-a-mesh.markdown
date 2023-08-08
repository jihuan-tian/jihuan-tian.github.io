---
layout: post
title: Construct topological data structures from a mesh
date: 2023-07-03
categories: [math]
tags: [differential-geometry,cmu-ddg,snippet]
mathjax: true
---

When we construct topological data structures from a mesh, such as the
signed incidence matrix associating $$k$$-simplices and
$$k+1$$-simplices therein, don’t be keen to directly achieve this target
in one round. Sometimes, we need several intermediate steps and data
structures as a scaffold for the construction. For example, we can
firstly create a collections of dynamic vectors storing the incident
edges of each cell in the mesh, then transform these data into the final
compressed sparse row (CSR) matrix format. We can see that to realize
the final algorithm with the minimal storage and time complexity, it is
worthwhile to implement complex mechanisms with affordable overheads.
There is actually no free lunch!

incidence OED The situation of one locus with respect to another
when they have a common point or points, but do not completely coincide;
e.g. of a point to a line on which it lies, of a point or a line to a
plane in which it lies, or of two intersecting lines to each other.

From the German of Schubert, Kalkul der Abzähl. Geom. (1879) 25.

