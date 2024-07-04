---
layout: post
title: Domain, range and dual spaces in BEM
date: 2024-07-04
categories: [math]
tags: [BEM]
mathjax: true
---

In Galerkin FEM, we are dealing with two function spaces, the trial space $$X $$ and the test space $$Y $$. The test function $$v\in Y $$ is directly applied to the two sides of the operator equation. If we take the Laplace problem as example, we&rsquo;ll then apply the Green identity to obtain the variational form or weak form. The weak form contains an integration term $$\left( \nabla u,\nabla v \right) $$, which is product of the differentials of $$v $$ and $$u $$. If $$u $$ and $$v $$ belong to $$H_0^1(\Omega) $$, which means both of them as well as their first order partial derivatives are square integrable, the integration term is the $$L_2 $$-inner product of the gradient of $$v $$ and $$u $$ in the Cartesian product space $$\left[ L_2(\Omega) \right]^d $$, where $$d $$ is the spatial dimension.

In Galerkin BEM, a boundary integral equation will be considered, which is equivalent to the original PDE. An integral operator, such as the single layer potential (SLP) integral operator $$V $$, operates on the solution function $$u $$ in the PDE

$$
\begin{equation}
(Vu)(x) = \int_{\Gamma} U^{*}(x,y) u(y) ds_y,
\end{equation}
$$

where $$U^{*}(x, y) $$ is the fundamental solution.

The test function $$v $$ will not be directly applied to the solution function $$u $$ or its differential as in FEM, but to the result function returned from the integral operator. Let the domain space and range space of $$V $$ be $$X $$ and $$Z $$. For example, $$V: H^{-1/2}(\Gamma) \rightarrow H^{1/2}(\Gamma) $$. Obviously, the trial space is the domain space of the integral operator. The test space $$Y $$ is not the same as the domain space any more as in FEM. Actually, the test function should belong to the dual space $$Z' $$ of the range space $$Z $$ and is applied to a function in the range space via duality pairing between $$Z $$ and $$Z' $$. Therefore, the test function space for the integral operator $$V $$ is $$Y=H^{-1/2}(\Gamma) $$, which happens to be the same as the domain space $$X $$. This explains why the discretized matrix associated with $$V $$ is symmetric.

However, for the double layer integral operator $$K: H^{1/2}(\Gamma) \rightarrow H^{1/2}(\Gamma) $$, the trial function space is $$H^{1/2}(\Gamma) $$ and the domain space is $$H^{-1/2}(\Gamma) $$, which are different. Hence, the matrix for $$K $$ is generally not a square matrix.

See also [Difference between interpolation and projection in FEM]({% post_url 2022-05-24-difference-between-interpolation-and-projection-in-fem %}).
