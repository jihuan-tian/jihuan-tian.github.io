---
layout: post
title: Fundamental theorems in PDE theory
date: 2024-06-19
categories: [math]
tags: [PDE]
mathjax: true
---

- [Riesz representation theorem](#org60d4829)
- [Lax-Milgram Lemma](#org650a387)
- [Cea&rsquo;s Lemma](#org96b6675)
- [Strang Lemma](#org4dffff6)


<a id="org60d4829"></a>

# Riesz representation theorem

Let $$X $$ be a Hilbert space and $$X' $$ be its dual space with respect to the duality pairing $$\left\langle \cdot,\cdot \right\rangle $$. Let $$\left\langle \cdot,\cdot \right\rangle_X $$ be the inner product on $$X $$. The dual space $$X' $$ is the set of all linear and bounded functionals on $$X $$. For any $$f\in X' $$, there exists an unique $$u\in X$$ such that applying $$f $$ to any $$v\in X $$, i.e. its duality pairing with $$v $$, is equal to the inner product of $$u $$ and $$v $$, i.e.

$$
\begin{equation}
\left\langle f,v \right\rangle = \left\langle u,v \right\rangle_X.
\end{equation}
$$

Furthermore, $$\lVert u \rVert_X = \lVert f \rVert_{X'} $$, where $$\lVert \cdot \rVert_{X'} $$ is the operator norm on $$X' $$.

Not only states this theorem the equivalence between the Hilbert space $$X $$ and its dual space $$X' $$, it can also be understood as an existence and uniqueness theorem for the solution of the above simple variational problem, i.e. find $$u\in X $$ such that $$\left\langle u,v \right\rangle_X = \left\langle f,v \right\rangle $$ for any $$v\in X $$.


<a id="org650a387"></a>

# Lax-Milgram Lemma

This is an existence and uniqueness theorem for the solution of an operator equation as well as its equivalent variational formulation, whose key feature is governed by the operator $$A: X \rightarrow X' $$ or the corresponding bilinear form $$a(\cdot,\cdot) $$.

Operator equation is

$$
\begin{equation}
Au = f
\end{equation}
$$

and its variational formulation is

$$
\begin{equation}
a(u,v) = \left\langle Au,v \right\rangle = \left\langle f,v \right\rangle \quad \forall v\in X.
\end{equation}
$$

The boundedness and $$X $$-ellipticity of $$A $$ ensures the existence and uniqueness of the solution $$u $$. N.B. Ellipticity of an operator is defined with respect to with its domain.


<a id="org96b6675"></a>

# Cea&rsquo;s Lemma

It describes the stability estimate and quasi-optimal error estimate for the solution of the **discrete** variational problem obtained from the Galerkin-Bubnov method.

$$
\begin{equation}
  \label{eq:variational-problem-finite-dim}
  \left\langle Au_M,v_M \right\rangle = \left\langle f,v_M \right\rangle \quad \forall v_M\in X_M,
\end{equation}
$$

where $$X_M $$ is the finite dimensional approximation of $$X $$. N.B. The said quasi-optimal error estimate means the error measured by $$X $$-norm between the true solution $$u $$ and the finite dimensional solution $$u_M $$ is controlled by the infimum of the space approximation error $$\inf_{v_M\in X_M} \lVert u - v_M \rVert_X $$. This means as long as the finite dimensional space $$X_M $$ is selected good enough with respect to the original Sobolev space $$X $$, the solution error can be small enough. This ensures it is meaningful to obtain a better result by increasing the mesh density or polynomial order of the finite element.

The adopted finite dimensional space $$X_M $$ leads to the discretization error, which can be considered as a perturbation to the original continuous problem. As regards spatial finite dimension, it is achieved by a triangulation of the domain. As regards finite dimension caused by finite element, it is achieved by a set of polynomials which forms a subspace of the Sobolev space (This is the so-called conforming finite element and the wording **conforming** should be differentiated from that used in **conforming mesh**. The latter means there are no hanging nodes in the mesh).


<a id="org4dffff6"></a>

# Strang Lemma

Not only the trial and test function spaces (usually Sobolev spaces) can be approximated by finite dimensional spaces via the Galerkin-Bubnov method, the linear form on the right hand side of the variational problem in Equation \ref{eq:variational-problem-finite-dim} can also be approximated. For example, if the linear functional $$f\in X' $$ on the right hand side is represented as $$Bg $$, where $$B: Y \rightarrow X' $$ is a bounded linear operator and $$g\in Y $$, the finite dimensional approximation $$g_N $$ of $$g $$ leads to another source of perturbation to the PDE. Strang Lemma then characterizes the quasi-optimal error estimate in this case, i.e. the new solution error is controlled by a scaled sum of the space approximation error $$\inf_{v_M\in X_M} \lVert u - v_M \rVert_X $$ and the right hand side data error $$\lVert g - g_N \rVert_Y $$.

{{ "2024-06-19-fundamental-theorems-in-pde-theory" | backlink }}
