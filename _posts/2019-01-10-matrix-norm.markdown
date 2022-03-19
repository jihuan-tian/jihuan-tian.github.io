---
layout: post
title: Matrix norm
date: 2019-01-10
categories: [math]
tags: [topology,linear-algebra]
mathjax: true
disqus: y
---

In our [previous post]({% post_url 2019-01-08-theo20-3-and-metric-equivalence %}), we introduced various definitions of matrix norms in $$\mathbb{R}^{n \times n}$$ based on the corresponding vector norms in $$\mathbb{R}^n$$. Meanwhile, the equivalence of different vector norms and their induced metrics and topologies in $$\mathbb{R}^n$$ is also inherited into $$\mathbb{R}^{n \times n}$$. In this article, we’ll show why the above defined matrix norms are valid.

Generally, the definition of a matrix norm in $$\mathbb{R}^{n \times n}$$ should satisfy the following four conditions:

1. Positive definiteness: for all $$A \in \mathbb{R}^{n \times n}$$, $$\norm{A} \geq 0$$. $$\norm{A} = 0$$ if and only if $$A = 0$$.
2. Absolute homogeneity: for all $$\alpha \in \mathbb{R}$$ and $$A \in \mathbb{R}^{n \times n}$$, $$\norm{\alpha A} = \abs{\alpha} \norm{A}$$.
3. Triangle inequality: for all $$A, B \in \mathbb{R}^{n \times n}$$, $$\norm{A + B} \leq \norm{A} + \norm{B}$$.
4. Sub-multiplicity: for all $$A, B \in \mathbb{R}^{n \times n}$$, $$\norm{AB} \leq \norm{A} \norm{B}$$.

Therefore, we need to prove the following theorem in order to meet the above requirements.

**Theorem** Let $$\norm{\cdot}$$ be a norm on $$\mathbb{R}^n$$. Then for all $$A \in \mathbb{R}^{n \times n}$$, its matrix norm $$\zeta: \mathbb{R}^{n \times n} \rightarrow \mathbb{R}$$ can be defined as

$$
\zeta(A) = \sup_{\forall \vect{x} \in \mathbb{R}^n, \vect{x} \neq 0} \frac{\norm{A \vect{x}}}{\norm{\vect{x}}} = \sup_{\forall \vect{x} \in \mathbb{R}^n, \norm{\vect{x}}=1} \norm{A \vect{x}}
$$

**Proof** a) Positive definiteness and absolute homogeneity directly inherit from vector norms.

b) The triangle inequality can be proved as following.

$$
\begin{aligned}
\zeta(A + B) &= \sup_{\forall \vect{x} \in \mathbb{R}^n, \vect{x} \neq 0} \frac{\norm{(A + B) \vect{x}}}{\norm{\vect{x}}} = \sup_{\forall \vect{x} \in \mathbb{R}^n, \vect{x} \neq 0} \frac{\norm{A\vect{x} + B\vect{x}}}{\norm{\vect{x}}} \\
& \leq \sup_{\forall \vect{x} \in \mathbb{R}^n, \vect{x} \neq 0} \frac{\norm{A\vect{x}} + \norm{B\vect{x}}}{\norm{\vect{x}}} \leq \sup_{\forall \vect{x} \in \mathbb{R}^n, \vect{x} \neq 0} \frac{\norm{A\vect{x}}}{\norm{\vect{x}}} + \sup_{\forall \vect{x} \in \mathbb{R}^n, \vect{x} \neq 0} \frac{\norm{B\vect{x}}}{\norm{\vect{x}}} = \zeta(A) + \zeta(B).
\end{aligned}
$$

c) For sub-multiplicity, we have

$$
\begin{aligned}
\zeta(AB) &= \sup_{\forall \vect{x} \in \mathbb{R}^n, \vect{x} \neq 0} \frac{\norm{AB\vect{x}}}{\norm{\vect{x}}} = \sup_{\forall \vect{x} \in \mathbb{R}^n, \vect{x} \neq 0} \frac{\norm{AB\vect{x}} \norm{B\vect{x}}}{\norm{B\vect{x}}\norm{\vect{x}}} \\
&\leq \sup_{\forall \vect{x} \in \mathbb{R}^n, \vect{x} \neq 0} \frac{\norm{A\vect{x}}}{\norm{\vect{x}}} \cdot \sup_{\forall \vect{x} \in \mathbb{R}^n, \vect{x} \neq 0} \frac{\norm{B\vect{x}}}{\norm{\vect{x}}} = \norm{A} \cdot \norm{B}.
\end{aligned}
$$

d) Prove $$\zeta(A) = \sup_{\forall \vect{x} \in \mathbb{R}^n, \norm{\vect{x}} = 1} \norm{A\vect{x}}$$.

Note that $$\frac{1}{\norm{\vect{x}}}$$ is a scalar value in $$\mathbb{R}$$, then with the proved absolute homogeneity, we have

$$
\zeta(A) = \sup_{\forall \vect{x} \in \mathbb{R}^n, \vect{x} \neq 0} \frac{\norm{A\vect{x}}}{\norm{\vect{x}}} = \sup_{\forall \vect{x} \in \mathbb{R}^n, \vect{x} \neq 0} \left\Vert A \cdot \frac{\vect{x}}{\norm{\vect{x}}} \right\Vert.
$$

By letting $$\vect{x}' = \frac{\vect{x}}{\norm{\vect{x}}}$$, we have this part proved.

Summarizing a) to d), $$\norm{\cdot}$$ is literally a matrix norm induced from the corresponding vector norm.

Next, we prove the validity of the detailed formulations of the matrix norms, i.e.

1. 1-norm: $$\norm{A}_1 = \max_{1 \leq j \leq n} \sum_{i=1}^n \abs{a_{ij}}$$, which is the maximum absolute column sum;
2. 2-norm: $$\norm{A}_2 = \sqrt{\rho(A^T A)}$$, where $$\rho$$ represents the spectral radius, i.e. the maximum eigenvalue of $$A^TA$$;
3. $$\infty$$-norm: $$\norm{A}_{\infty} = \max_{1 \leq i \leq n} \sum_{j=1}^n \abs{a_{ij}}$$, which is the maximum absolute row sum.

a) 1-norm: Because

$$
\begin{aligned}
\norm{A\vect{x}}_1 &= \sum_{i=1}^n \left\vert \sum_{j=1}^n a_{ij} x_j \right\vert \leq \sum_{i=1}^n \sum_{j=1}^n \abs{a_{ij} x_j} = \sum_{j=1}^n \left( \abs{x_j} \sum_{i=1}^n \abs{a_{ij}} \right) \\
&\leq \left( \sum_{j=1}^n \abs{x_j} \right) \cdot \max_{1 \leq j \leq n} \left( \sum_{i=1}^n \abs{a_{ij}} \right),
\end{aligned}
$$

we have

$$
\norm{A}_1 \leq \sup_{\forall \vect{x} \in \mathbb{R}^n, \vect{x} \neq 0} \frac{\norm{A\vect{x}}_1}{\norm{\vect{x}}_1} \leq \frac{\left( \sum_{j=1}^n \abs{x_j} \right) \cdot \max_{1 \leq j \leq n} \left( \sum_{i=1}^n \abs{a_{ij}} \right)}{\sum_{j=1}^n \abs{x_j}} = \max_{1 \leq j \leq n} \left( \sum_{i=1}^n \abs{a_{ij}} \right).
$$

Then, we need to show that the maximum value on the right hand side is achievable.

Assume that when $$j = j_0$$, $$\sum_{i=1}^n \abs{a_{ij}}$$ has the maximum value. If this value is zero, it means $$A$$ is a zero matrix and the definition of matrix 1-norm is trivially true. If this value is not zero, by letting $$\vect{x} = (\delta_{ij_0})_{i \geq 1}^n$$ with $$\delta_{ij_0}$$ being the Kronecker delta, we have

$$
\frac{\norm{A\vect{x}}_1}{\norm{\vect{x}}_1} = \frac{\sum_{i=1}^n \abs{a_{ij_0}}}{1} = \max_{1 \leq j \leq n} \left( \sum_{i=1}^n \abs{a_{ij}} \right).
$$

b) 2-norm: The proof for this part needs the *intervention* of inner product $$\langle \cdot, \cdot \rangle$$ of vectors in $$\mathbb{R}^n$$, from which the vector 2-norm can be induced. Then we have

$$
\norm{A}_2 = \sup_{\forall \vect{x} \in \mathbb{R}^n, \vect{x} \neq 0} \frac{\norm{A\vect{x}}_2}{\norm{\vect{x}}_2} = \sup_{\forall \vect{x} \in \mathbb{R}^n, \vect{x} \neq 0} \sqrt{\frac{\langle A\vect{x}, A\vect{x} \rangle}{\langle \vect{x}, \vect{x} \rangle}} = \sup_{\forall \vect{x} \in \mathbb{R}^n, \vect{x} \neq 0} \sqrt{\frac{\langle A^*A\vect{x}, \vect{x} \rangle}{\langle \vect{x}, \vect{x} \rangle}},
$$

where $$A^*$$ is the adjoint operator, i.e. transpose of $$A$$. Therefore, $$A^*A$$ is a real valued symmetric matrix which has $$n$$ real eigenvalues $$\{\lambda_i\}_{i=1}^n$$ with $$0 \leq \lambda_1 \leq \cdots \leq \lambda_n$$ and $$n$$ corresponding orthonormal eigenvectors $$\{\vect{v}_i\}_{i=1}^n$$ (N.B. There may be duplicates in the eigenvalues).  For all $$\vect{x} \in \mathbb{R}^n$$, it can be expanded as $$\vect{x} = \sum_{i=1}^n a_i \vect{v}_i$$ and $$A^*A\vect{x} = \sum_{i=1}^n a_i A^*A \vect{v}_i = \sum_{i=1}^n a_i \lambda_i \vect{v}_i$$. Then we have

$$
\begin{aligned}
\langle A^*A\vect{x}, \vect{x} \rangle &= \left\langle \sum_{i=1}^n a_i \lambda_i \vect{v}_i, \sum_{j=1}^n a_j \vect{v}_j \right\rangle = \sum_{i=1}^n \sum_{j=1}^n \lambda_i a_i^2 \langle \vect{v}_i, \vect{v}_j \rangle \\
&= \sum_{i=1}^n \sum_{j=1}^n \lambda_i a_i^2 \delta_{ij} = \sum_{i=1} \lambda_i a_i^2.
\end{aligned}
$$

Meanwhile,

$$
\langle \vect{x}, \vect{x} \rangle = \left\langle \sum_{i=1}^n a_i \vect{v}_i, \sum_{j=1}^n a_j \vect{v}_j \right\rangle = \sum_{i=1}^n \sum_{j=1}^n a_i a_j \langle \vect{v}_i, \vect{v}_j \rangle = \sum_{i=1}^n a_i^2.
$$

Therefore,

$$
\frac{\norm{A\vect{x}}_2}{\norm{\vect{x}}_2} \leq \sqrt{\frac{\lambda_n \sum_{i=1}^n a_i^2}{\sum_{i=1}^n a_i^2}} = \sqrt{\lambda_n}.
$$

By letting $$a_1 = a_2 = \cdots = a_{n-1} = 0$$ and $$a_n = 1$$, we have $$\frac{\norm{A\vect{x}}_2}{\norm{\vect{x}}_2} = \sqrt{\lambda_n}$$. Hence,

$$
\norm{A}_2 = \sqrt{\lambda_n} = \sqrt{\rho(A^*A)}
$$

and the definition of matrix 2-norm is valid.

c) $$\infty$$-norm:

$$
\begin{aligned}
\norm{A\vect{x}}_{\infty} &= \max_{1 \leq i \leq n} \left( \left\vert \sum_{j=1}^n a_{ij} x_j \right\vert \right) \leq \max_{1 \leq i \leq n} \left( \sum_{j=1}^n \abs{a_{ij}} \cdot \abs{x_j} \right) \\
&= \max_{1 \leq i \leq n} \left( \left( \sum_{j=1}^n \abs{a_{ij}} \right) \cdot \left( \max_{1 \leq j \leq n} \abs{x_j} \right) \right) = \left( \max_{1 \leq i \leq n} \sum_{j=1}^n \abs{a_{ij}} \right) \cdot \left( \max_{1 \leq j \leq n} \abs{x_j} \right) \\
\norm{\vect{x}}_{\infty} &= \max_{1 \leq i \leq n} \abs{x_i}
\end{aligned}
$$

Therefore, $$\frac{\norm{A\vect{x}}_{\infty}}{\norm{\vect{x}}_{\infty}} \leq \max_{1 \leq i \leq n} \sum_{j=1}^n \abs{a_{ij}}$$. Then, we need to prove this maximum value is achievable.

Assume when $$i = i_0$$, $$\sum_{j=1}^n \abs{a_{i_0 j}}$$ achieves the maximum. If this value is zero, $$A$$ is a zero matrix and the definition of matrix $$\infty$$-norm is trivially true. If this value is not zero, by letting $$\vect{x} = (\sgn(a_{i_0 1}), \cdots, \sgn(a_{i_0 n}))^{\rm T}$$, we have $$\norm{\vect{x}}_{\infty} = 1$$ and $$\norm{A\vect{x}}_{\infty} = \sum_{j=1}^n \abs{a_{i_0 j}} = \max_{1 \leq i \leq n} \sum_{j=1}^n \abs{a_{ij}}$$.  Hence, $$\frac{\norm{A\vect{x}}_{\infty}}{\norm{\vect{x}}_{\infty}} = \max_{1 \leq i \leq n} \sum_{j=1}^n \abs{a_{ij}}$$ and the definition of $$\infty$$-norm is valid.
