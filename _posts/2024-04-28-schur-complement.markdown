---
layout: post
title: Schur complement
date: 2024-04-28
categories: [math]
tags: [BEM]
mathjax: true
---

When there are two variables in a PDE to be solved, the system matrix for the discretized variational formulation or weak form is a $$2\times 2$$ block matrix instead of a single block,

$$
\begin{equation}
  \begin{pmatrix}
    M_{11} & M_{12} \\
    M_{21} & M_{22}
  \end{pmatrix}
  \begin{pmatrix}
    u \\
    w
  \end{pmatrix} =
  \begin{pmatrix}
    f_1 \\
    f_2
  \end{pmatrix}.
\end{equation}
$$

Such a system matrix appears in the boundary integral equation for the Laplace problem with mixed boundary condition:

$$
\begin{equation}
\begin{pmatrix}
  \gamma_0^{\rm int} u \\
  \gamma_1^{\rm int} u
\end{pmatrix} =
\begin{pmatrix}
  (1-\sigma) I - K & V \\
  D & \sigma I + K'
\end{pmatrix}
\begin{pmatrix}
  \gamma_0^{\rm int} u \\
  \gamma_1^{\rm int} u
\end{pmatrix} +
\begin{pmatrix}
  N_0 f \\
  N_1 f
\end{pmatrix}.
\end{equation}
$$

Schur complement is often used to solve this equation system.

1.  Multiply the equation in first row with $$-M_{21}M_{11}^{-1} $$ and add the result to the second row.
    
    $$
    \begin{equation}
      \begin{pmatrix}
        M_{11} & M_{12} \\
        0 & M_{22} - M_{21}M_{11}^{-1}M_{12}
      \end{pmatrix}
      \begin{pmatrix}
        u \\ w
      \end{pmatrix} =
      \begin{pmatrix}
        f_1 \\ f_2 - M_{21}M_{11}^{-1}f_1
      \end{pmatrix}.
    \end{equation}
    $$
    
    Here, $$M_{22} - M_{21}M_{11}^{-1}M_{12} $$ is called the Schur complement of $$M$$ with respect to the block $$M_{11}$$.

2.  Solve the following equation for $$w$$.
    
    $$
    \begin{equation}
      \left( M_{22} - M_{21}M_{11}^{-1}M_{12} \right) w = f_2 - M_{21}M_{11}^{-1} f_1.
    \end{equation}
    $$

3.  Solve the following equation for $$u$$.
    
    $$
    \begin{equation}
    \label{eq:2}
    M_{11} u = f_1 - M_{12}w.
    \end{equation}
    $$

We can see that the Schur complement method is actually the Gauss-Seidel (Gauss elimination) method for a $$2\times 2$$ matrix, or the method for solving linear equations of two variables which we once learnt in middle school. *Sometimes a high level mathematical method, such as the Schur complement used in PDE, tallies with an elementary method, both of which bear a same idea or spirit.*

The benefit of this method is by decomposing the original large system matrix into two smaller problems, less memory is needed and the iterative solver usually converges faster.
