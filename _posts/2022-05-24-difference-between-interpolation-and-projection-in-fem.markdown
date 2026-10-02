---
layout: post
title: Difference between interpolation and projection in FEM
date: 2022-05-24
categories: [math]
tags: [FEM]
mathjax: true
---

Assume $$\mathcal{V}_h$$ is a finite element space with the nodal basis $$\left\{ \phi_1,\phi_2,\cdots,\phi_n \right\}$$. Using this basis as the trial space, the continuous function $$f$$ can be discretized as $$f_h$$ by following the ansatz $$f_h=\sum_{i=1}^n a_i\phi_i$$. There are two ways to achieve this: interpolation and projection (or more specifically, $$L_2$$-projection).

Interpolation means ensuring $$f_h$$ to have exact function values as $$f$$ at all support points of the trial functions. The support point of a trial function is the point where its value equals one and this is obvious for a nodal basis function $$\phi_j$$, because $$l_i(\phi_j) = \delta_{ij}$$ should be satisfied, where $$l_i$$ is the $$i$$-th degree of freedom in the dual space of the finite element space. Let $$\left\{ x_1,x_2,\cdots,x_n \right\}$$ be the list of nodal points associated with the basis functions and evaluate $$f_h$$ at each point $$ f_h(x_k)=\sum_{i=1}^n a_i\phi_i(x_k)=\sum_{i=1}^n a_i\delta_{ik}=a_k \quad k=1,\cdots,n. $$ Then $$a_k$$ can be directly assigned with the value $$f(x_k)$$.

To compute the $$L_2$$-projection of $$f$$ onto $$\mathcal{V}_h$$, we need to ensure that for any function $$v_h$$ in $$\mathcal{V}_h$$, its $$L_2$$ inner product with $$f_h$$ and $$f$$ should be the same, i.e. $$f$$ is equivalent to $$f_h$$ in the sense of $$L_2$$-projection. Then the following equation should be solved $$ (f_{h},\phi_i) =(f,\phi_i) \quad i=1,\cdots,n. $$ This is equivalent to

$$
\begin{equation}
\left(\sum_{j=1}^n a_j\phi_j,\phi_i\right) =(f,\phi_i) \quad i=1,\cdots,n.
\label{eq:projection}
\end{equation}
$$

In matrix form, this is $$M F_h = F$$, where $$M_{ij}=\int_{\Omega}\phi_i\phi_j dx$$ is the mass matrix, $$F_i=\int_{\Omega} f\phi_i dx$$ and $$F_h=(a_1,\cdots,a_n)^T$$ is the vector of expansion coefficients.

From above we can conclude the following points:

1.  Unless the adopted finite element nodal basis is orthonormal, i.e. $$\int_{\Omega}\phi_i\phi_j dx = \delta_{ij}$$, the mass matrix $$M$$ is usually not an identity matrix and the $$L_2$$-projection of $$f$$ onto $$\mathcal{V}_h$$ is **not** a simple inner product with each basis function $$\phi_i$$, but the vector of inner product values $$F $$ should further be left-multiplied by the inverse of the mass matrix $$M $$.
2.  Interpolation and $$L_2$$-projection of a function onto a finite element space usually generate different vectors of expansion coefficients $$\{a_i\}_{i=1}^n $$ for $$f_h$$. Because interpolation produces accurate function values at support points of nodal basis functions, it is suitable for assigning boundary conditions or initial values to the partial differential equation.
3.  From a differential geometry point of view, the mass matrix $$M $$ can be considered as a metric tensor $$g $$ (2-rank covariant tensor) with respect to the function space $$\mathcal{V}_h$$ with the basis $$\left\{ \phi_1,\cdots,\phi_n \right\} $$. The right hand side vector $$F $$ in Equation \eqref{eq:projection} can be considered as a cotangent vector belonging to the dual space. After applying the inverse of the metric tensor $$M^{-1} $$, which is equivalent to the $$\sharp $$ operator in differential geometry, $$F $$ is transformed to the tangent vector $$F_h $$.

{{ "2022-05-24-difference-between-interpolation-and-projection-in-fem" | backlink }}
