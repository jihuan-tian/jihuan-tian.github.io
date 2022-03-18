---
layout: post
title: Different ways of constructing continuous functions
date: 2018-12-19
categories: [math]
tags: [topology]
mathjax: true
disqus: y
---

This post summarises different ways of constructing continuous functions, which are introduced in Section 18 of James Munkres “Topology”.

1. Constant function.
2. Inclusion function.
   
   N.B. The function domain should have the subspace topology relative to the range.
3. Composition of continuous functions. Specifically, composition of continuous real-valued functions via simple arithmetic, i.e. sum, difference, product and quotient. For the case of quotient, the function as the denominator should never be evaluated to 0.
4. Restricting the domain of a continuous function.
   
   N.B. The reduced domain should be assigned the subspace topology with respect to the original domain.
5. Restricting or expanding the range of a continuous function.
   
   N.B. The smaller range should have the subspace topology with respect to the larger range.
6. Local formulation of continuity,i.e. the function is continuous if it is still continuous after restricting its domain to each open set in an open covering of the original domain.
7. Pasting continuous functions with their domains on patches of closed sets which cover the whole domain.

   Comment: In the overlapping subdomain, the functions on different patches should be defined consistently. This condition is not required in “local formulation of continuity”, where the covering of the whole domain is made from open sets instead of closed sets. From this difference, we can *sense* the difference between open set and closed set. The former is intrinsically related to continuity, which can be phenomenologically construed as that the open sets can **infiltrate** into one another infinitely, even though the amount of infiltration is often infinitesimal if a metric is also assigned to the space. On the contrary, the latter has a clearly set demarcation or buffer zone between the functions on different patches without further penetration or interaction. Therefore, it does not intrinsically imply continuity and the function values in the overlapping subdomain must be consistent to ensure the continuity of the fully assembled function.
8. Maps into products, which ensures the equivalence between the continuity of the original function and that of its coordinate functions.
9. Uniform limit of a sequence of continuous functions. 

    N.B. The range space of these functions should have a metric.
