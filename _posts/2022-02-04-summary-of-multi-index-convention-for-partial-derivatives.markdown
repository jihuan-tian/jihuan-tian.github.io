---
layout: post
title: Summary of multi-index convention for partial derivatives
date: 2022-02-04
categories: [math]
tags: [PDE]
mathjax: true
---

Let $$d$$ be the spatial dimension. $$\alpha = (\alpha_1, \cdots, \alpha_d) \in \mathbb{N}_0^d$$.

$$
 \lvert \alpha \rvert = \sum_{i = 1}^d \alpha_i
$$

The factorization of a multi-index is equal to the product of the factorization of each component index:

$$
 \alpha ! = \prod_{i = 1}^d \alpha_i !
$$

The multi-index is distributed to each coordinate component of $$x \in \mathbb{R}^d$$:

$$
 x^{\alpha} = \prod_{i = 1}^d x_i^{\alpha_i}
$$

The $$\lvert \alpha \rvert$$-fold mixed derivative with respect to $$x$$:

$$
 \begin{array}{rl} \partial_x^{\alpha} & = \prod_{i = 1}^d \partial_{x_i}^{\alpha_i} \\ \partial_x^{\alpha} x^{\beta} & = \frac{\beta !}{(\beta - \alpha) !} x^{\beta - \alpha} \quad (\alpha \leq \beta) \end{array}
$$

where $$\beta \in \mathbb{N}_0^d$$, $$\alpha \leq \beta$$ means $$\alpha_i \leq \beta_i$$ for $$i = 1, \cdots, d$$ and $$\beta - \alpha$$ is the normal subtraction of two vectors. When $$\beta \equiv \alpha$$,

$$
 \partial_x^{\alpha} x^{\alpha} = \alpha !
$$

The combination for multi-index:

$$
 C_{\alpha}^{\beta} = \prod_{i = 1}^d C_{\alpha_i}^{\beta_i} \quad (\beta \leq \alpha)
$$

Proposition 1. (Leibniz formula for $$\lvert \alpha \rvert$$-fold partial derivatives)

$$
 \partial_x^{\alpha} (uv) = \sum_{\beta \leq \alpha} C_{\alpha}^{\beta} (\partial_x^{\beta} u) (\partial_x^{\alpha - \beta} v),
$$

where $$\alpha$$ and $$\beta$$ are multi-indices and $$x \in \mathbb{R}^d$$.

Proof 1\. When $$d=1$$, it is the classical Leibiniz formula in calculus.

2\. Assume it holds for $$d=n$$. Then for $$d=n+1$$, we have

$$
\begin{equation*}
    \pdiff_x^{\alpha}(uv) =\left( \prod_{i=1}^{n+1}\pdiff_{x_i}^{\alpha_i} \right)(uv) =
    \pdiff_{x_1}^{\alpha_1} \left( \prod_{i=2}^{n+1}\pdiff_{x_i}^{\alpha_i} \right)
\end{equation*}
$$

Let $$\tilde{\alpha}=(\alpha_2,\cdots,\alpha_{n+1})$$ and $$\tilde{x}=(x_2,\cdots,x_{n+1})$$,

$$
\begin{equation*}
  \begin{split}
      \text{Above} &= \pdiff_{x_1}^{\alpha_1}
      \pdiff_{\tilde{x}}^{\tilde{\alpha}}(uv) = \pdiff_{x_1}^{\alpha_1}\left(
        \sum_{\tilde{\beta}\leq\tilde{\alpha}}C_{\tilde{\alpha}}^{\tilde{\beta}}(\pdiff_x^{\tilde{\beta}}u)(\pdiff_x^{\tilde{\alpha}-\tilde{\beta}}v)
      \right) \\
      &= \sum_{\tilde{\beta}\leq\tilde{\alpha}}C_{\tilde{\alpha}}^{\tilde{\beta}}
      \underbrace{\pdiff_{x_1}^{\alpha_1}\left[(\pdiff_x^{\tilde{\beta}}u)(\pdiff_x^{\tilde{\alpha}-\tilde{\beta}}v)\right]}_{\text{Apply the Leibniz formula for $d=1$}} \\
      &= \sum_{\tilde{\beta}\leq\tilde{\alpha}}C_{\tilde{\alpha}}^{\tilde{\beta}}\left[
        \sum_{\beta_1\leq\alpha_1}C_{\alpha_1}^{\beta_1}(\pdiff_{x_1}^{\beta_1}\pdiff_{\tilde{x}}^{\tilde{\beta}}u)(\pdiff_{x_1}^{\alpha_1-\beta_1}\pdiff_{\tilde{x}}^{\tilde{\alpha}-\tilde{\beta}}v)
      \right] \\
      &= \sum_{\tilde{\beta}\leq\tilde{\alpha}}\sum_{\beta_1\leq\alpha_1}C_{\tilde{\alpha}}^{\tilde{\beta}}C_{\alpha_1}^{\beta_1}(\pdiff_x^{\beta}u)(\pdiff_x^{\alpha-\beta}v) \\
      &= \sum_{\beta\leq\alpha}C_{\alpha}^{\beta}(\pdiff_x^{\beta}u)(\pdiff_x^{\alpha-\beta}v).
  \end{split}
\end{equation*}
$$

3\. Apply the principle of mathematical induction, the proposition is proved.

Proposition 2. (Taylor expansion for multi-dimensional functions) Let $$f : X \rightarrow \mathbb{R}$$ be a function from $$C^m (X)$$ with $$X \subset \mathbb{R}^d$$. Let $$x_0 \in X$$ be an expansion center. The Taylor expansion around $$x_0$$ is

$$
f (x) = \sum_{\text{$\begin{array}{c} \alpha \in \mathbb{N}_0^d\\ \lvert \alpha \rvert \leq m \end{array}$}} (x - x_0)^{\alpha} \frac{1}{\alpha !} \partial_x^{\alpha} f (x_0) + R_r,
$$

where $$R_r$$ is the high order remainder.

Proposition 3. The total number of terms in the $$m$$-th order Taylor expansion for a function defined on $$X \subset \mathbb{R}^d$$ is $$C_{m + d}^d$$.

Proof  The number of terms in the Taylor expansion for $$\abs{\alpha}=k$$ is equivalent to the number of ways for distributing the $$k$$ times of partial derivatives to the $$d$$ coordinate components, some of which may be assigned no derivatives at all. Hence the answer is $$C_{k+d-1}^{d-1}$$. The total number of terms in the Taylor expansion is

$$
\begin{equation*}
  \begin{split}
    \sum_{k=0}^{m}C_{k+d-1}^{d-1} &= C_{d-1}^{d-1} + C_d^{d-1} + \cdots + C_{m+d-1}^{d-1} \\
    \text{Replace $C_{d-1}^{d-1}$ with $C_d^d$,} \\
    &= C_d^d + C_d^{d-1} + C_{d+1}^{d-1} + \cdots + C_{m+d-1}^{d-1} \\
    \text{Apply $C_n^{m-1} + C_n^m = C_{n+1}^m$,} \\
    &= C_{d+1}^d + C_{d+1}^{d-1} + \cdots + C_{m+d-1}^{d-1} \\
    &= C_{m+d}^d.
  \end{split}
\end{equation*}
$$

Comment For Sobolev norms in [^Ada75], there are also partial derivatives (in the weak sense) of different orders:

$$
 \lVert u \rVert_{m, p} = \left( \sum_{\lvert \alpha \rvert \leq m} \lVert \partial^{\alpha} u \rVert_p^p \right)^{1 / p} \quad (1 \leq p < \infty) .
$$

References

[^Ada75]: Robert Alexander Adams. Sobolev Spaces (Pure and applied mathematics, a series of monographs and textbooks). &nbsp;PURE AND APPLIED MATHEMATICS: A series of Monographs and Textbooks ISBN: 9780120441501. Academic Press, June 1975. 

{{ "2022-02-04-summary-of-multi-index-convention-for-partial-derivatives" | backlink }}
