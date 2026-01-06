---
layout: post
title: Understanding about Cauchy principal value and Hadamard finite part
date: 2026-01-06
categories: [math]
tags: [BEM]
mathjax: true
---

# Standard improper integral

If the integral domain is infinite, just evaluate the integral on a finite domain. Take the limit by extending the domain to infinite, and the integral should converge.

If the integral domain is finite but there is a singularity, such as integrate $$\frac{1}{r} $$ on $$\Gamma $$, evaluate the integral and take the limit $$r \rightarrow 0 $$. The integral should converge. Therefore, no special treatment is needed.


# Cauchy principal value

-   Firstly removes a ball with a radius $$\varepsilon $$ centered as the singularity.
-   Then evaluate the integral in the remaining domain with the hole.
-   Finally taking the limit $$\varepsilon \rightarrow 0 $$. Usually the terms resulted from the integral which depend on $$\varepsilon $$ will be cancelled during previous step.

Therefore, the singularity can be removed by approaching to it with a uniform speed. Cauchy principal value can be used to handle singularity of the order of $$\frac{1}{r^2} $$. Therefore, single layer potential, double layer potential and adjoint double layer potential can be handled with Cauchy principal value.

# Hadamard finite part

When the integrand has a higher singularity order such as $$\frac{1}{r^3} $$, an example of this is the hyper singular potential. If we still apply the Cauchy principal value method, the result will be infinite. Then the Hadamard finite part method should be adopted, which directly removes infinite terms from the integration result.

However, such infinite terms are not arbitrarily selected. A very important idea here is that the integral should not be understood as computing the area of the integrand over the surface, but as the derivative of the integral, in the sense of Cauchy principal value, of an integrand with a lower singularity order. Otherwise, there will be the case that even though the integrand is positive everywhere, the integration value from Hadamard finite part is negative.

In BEM, the hyper singular potential is just the surface normal gradient with respect to the variable $$x $$ of the double layer potential. This is just consistent with the above idea.

{{ "2026-01-06-understanding-about-cauchy-principal-value-and-hadamard-finite-part" | backlink }}
