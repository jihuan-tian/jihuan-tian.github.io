---
layout: post
title: Understanding about ellipticity of operators
date: 2024-06-07
categories: [math]
tags: [PDE]
mathjax: true
---

Let $$X $$ be a Hilbert space and $$X' $$ be its dual space. For a bounded linear operator $$A: X \rightarrow X' $$, its ellipticity condition is defined as

$$
\begin{equation}
  \label{eq:ellipticity-condition}
  \left\langle Av, v \right\rangle \geq c_1^A \lVert v \rVert_X^2 \quad \forall v \in X,
\end{equation}
$$

where $$\left\langle \cdot,\cdot \right\rangle $$ is the duality pairing.

Now let&rsquo;s compare this formulation with its discrete counterpart. Let $$\mathscr{A} $$ be the matrix in $$\mathbb{R}^{n\times n} $$ corresponding to $$A $$ which is discretized via the Galerkin method. Let $$x $$ be the vector in $$\mathbb{R}^n $$ related to $$v $$. Assume $$\mathscr{A} $$ has $$n $$ eigenvalues $$\lambda_1,\cdots,\lambda_n $$ and $$n $$ eigenvectors $$v_1,\cdots,v_n $$ (N.B. Even though the multiplicity of some of the eigenvalues may be larger than one, for the same number of eigenvectors spanning its eigenspace, we can still explicitly use different symbols to represent their same eigenvalue. Therefore, we allow duplicated values in the list $$\lambda_1,\cdots,\lambda_n $$. Because the sum of the multiplicity of all eigenvalues is $$n $$ and all the eigenspaces are orthogonal to each other, we can choose those eigenvectors $$v_1,\cdots,v_n $$ to form an orthonormal set. Then any vector $$x $$ in $$\mathbb{R}^n $$ can be expanded by this basis:

$$
\begin{equation}
x = \sum_{i=1}^n c_i v_i.
\end{equation}
$$

And the duality pairing can be represented as

$$
\begin{equation}
  x^{\mathrm{T}} \mathscr{A} x = \left( \sum_{i=1}^n c_iv_i^{\mathrm{T}} \right)
  \mathscr{A} \left( \sum_{j=1}^n c_jv_j \right) = \sum_{i,j} c_ic_j v_i^{\mathrm{T}}
  \mathscr{A} v_j = \sum_{i,j} c_ic_j \lambda_j (v_i,v_j),
\end{equation}
$$

where $$(\cdot,\cdot) $$ is the inner product in $$\mathbb{R}^n $$. Because $$v_1,\cdots,v_n $$ are orthonormal, we have $$(v_i,v_j) =\delta_{ij} $$. Hence,

$$
\begin{equation}
x^{\mathrm{T}} \mathscr{A} x = \sum_{i=1}^n \lambda_i c_i^2.
\end{equation}
$$

If $$\mathscr{A} $$ is positive definite, the solution to the linear system $$Ax = b $$ exists and is unique. Since all eigenvalues are larger than zero, we let $$\lambda_{\min} $$ be the minimum and then have

$$
\begin{equation}
\left( \mathscr{A}x, x \right) = x^{\mathrm{T}} \mathscr{A} x \geq \lambda_{\min} \sum_{i=1}^n c_i^2 = \lambda_{\min} \lVert x \rVert_{\mathbb{R}^n}^2.
\end{equation}
$$

We can see that this discrete formulation is consistent with the ellipticity condition. The ellipticity constant $$c_1^A $$ of the bounded linear operator $$A $$ corresponds to the minimum eigenvalue of the positive definite matrix $$\mathscr{A} $$. That&rsquo;s why the ellipticity condition is the key in the Lax-Milgram Lemma, which governs the existence and uniqueness of the solution for a PDE formed by $$A $$.

{{ 2024-06-07-understanding-about-ellipticity-of-operators | backlink }}
