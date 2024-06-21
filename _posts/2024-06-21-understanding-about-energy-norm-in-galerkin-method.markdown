---
layout: post
title: Understanding about energy norm used in Galerkin method
date: 2024-06-21
categories: [math]
tags: [PDE]
mathjax: true
---

<!-- l. 24 --><p class='indent'>   In this lecture “<a href='https://youtu.be/tvHRyAu9zLc?list=PL10zZbQGXP3OyzxhnYju2RJR8j_nu9FFB&amp;t=2813'>PDEs and applications</a>”, Prof. Hiptmair mentioned that the blow up of Galerkin
matrix condition number is related to the intrinsic instability of the boundary element basis in
the <span class='p1xb-x-x-109'>energy norm</span>. On the other hand, the discretization of the operator in the \(V\)-norm is perfectly
stable.
</p><!-- l. 26 --><p class='indent'>   In (<a href='#XBrennerMathematical2009'>Brenner</a>, page 4), <span class='p1xb-x-x-109'>energy inner product </span>is defined as the symmetric bilinear form \(a(\cdot ,\cdot )\). For a general second
order PDE, the bilinear form is 

$$
\begin{equation}  \label {eq:bilinear-form-2nd-order-pde} a(u,v):= \sum _{i,j=1}^d\int _{\Omega }a_{ji}(x)\frac {\pdiff u}{\pdiff x_{i}}\frac {\pdiff v}{\pdiff x_{j}}\intd x + \int _{\Omega }a_0uv \intd x.  \end{equation}
$$

<a id='x1-1001r1'></a>
</p><!-- l. 35 --><p class='indent'>   The symmetry of the bilinear form is due to the self-adjointness of the differential operator \(L\)


$$
\begin{equation}  \label {eq:diff-operator-2nd-order} (Lu)(x):= -\sum _{i,j=1}^d \frac {\pdiff }{\pdiff x_j} \left [ a_{ji}(x)\frac {\pdiff u}{\pdiff x_{i}} \right ] + a_0(x)u(x).  \end{equation}
$$

<a id='x1-1002r2'></a>
</p><!-- l. 43 --><p class='indent'>   Then in (<a href='#XBrennerMathematical2009'>Brenner</a>, page 5), <span class='p1xb-x-x-109'>energy norm </span>is defined via the bilinear form: 

$$
\begin{equation}  \label {eq:energy-norm} \lVert v \rVert _E = \sqrt {a(v,v)} \quad \forall v\in X.  \end{equation}
$$

<a id='x1-1003r3'></a> Meanwhile, \(a(\cdot ,\cdot )\) can also be considered
as an inner product on \(X\). Cauchy-Schwartz inequality also holds for such inner product and energy norm: 

$$
\begin{equation}  \lvert a(v,w) \rvert \leq \lVert v \rVert _E \lVert w \rVert _E.  \end{equation}
$$

<a id='x1-1004r4'></a> On the
other hand, the original norm and inner product on the space \(X\) can still be adopted, which has nothing to do with
the differential operator \(L\).
</p><!-- l. 54 --><p class='indent'>   Take the \(H^1(\Omega )\) Sobolev space as example, its standard norm is 

$$
\begin{equation}  \| u \|_{H^1(\Omega )} = \left ( \| u \|_{L^2(\Omega )}^2 + \| \nabla u \|_{(L^2(\Omega ))^n}^2 \right )^{1/2}.  \end{equation}
$$

<a id='x1-1005r5'></a> If the differential operator is \(L=-\Delta + I\), its corresponding
bilinear form is \(a(u,v) = \left \langle \nabla u, \nabla v \right \rangle + \left \langle u,v \right \rangle \). Then the norm \(\lVert u \rVert _{H^1(\Omega )}\) is equivalent to \(\sqrt {a(u,u)}\), so it is an energy norm.
</p><!-- l. 60 --><p class='indent'>   If the differential operator is \(L=-\Delta \), the bilinear form is \(a(u,v) = \left \langle \nabla u, \nabla v \right \rangle \). Then \(a(u,u) = \left \langle \nabla u, \nabla u \right \rangle \) and the energy norm \(\sqrt {a(u,u)}\) is actually the semi-norm
\(\lvert u \rvert _{H^1(\Omega )}\).
</p><!-- l. 62 --><p class='indent'>   In addition, because \(H^1(\Omega )\) is a subspace of \(L_2(\Omega )\), we can still assign the \(L_2\)-norm to \(H^1(\Omega )\). Of course, this norm is not the energy
norm.
</p><!-- l. 64 --><p class='indent'>   According to the definition of the standard \(H^1\)-norm, when the differential operator is \(L=-\Delta + I\), both \(L_2\)-norm and
\(H^1\)-semi-norm is smaller than the energy norm. When the differential operator is \(L=-\Delta \), while the \(H^1\)-semi-norm is
the same as the energy norm, whether \(L_2\)-norm is smaller than the energy norm seems unknown.
However, in (<a href='#XBrennerMathematical2009'>Brenner</a>, page 6), it is proved generally that the \(L_2\)-norm is much smaller than the energy
norm.
</p><!-- l. 66 --><p class='indent'>   N.B. The Ritz-Galerkin method ensures that the solution error is optimal in the energy norm. However, if
we use \(L_2\)-norm to measure the error, since for a same error function, its value is smaller than the
energy norm, the method is actually more stable. This explains the statement of Prof. Hiptmair at the
                                                                                               
                                                                                               
beginning.
</p><!-- l. 68 --><p class='indent'>   Finally, we can also see that the usually adopted function space norm and inner product on \(X\) only focus on the
continuity and smoothness of the function itself. The energy norm and inner product defined via
the bilinear form on \(X\) is related to the differential operator, or rather the physical property of the
system.
</p><!-- l. 1 --><p class='noindent'>
</p>
   <h3 class='likesectionHead'><a id='x1-2000'></a>References</h3>
<!-- l. 1 --><p class='noindent'>
  </p><div class='thebibliography'>
  <p class='bibitem'><span class='biblabel'>
<a id='XBrennerMathematical2009'></a><span class='bibsp'>   </span></span>Susanne C. Brenner. <span class='p1xi-x-x-109'>The Mathematical Theory of Finite Element Methods</span>. Springer New York, 3 edition.
  ISBN 978-1-4419-2611-1. URL <a class='url' href='https://book.douban.com/subject/4219448/#'><span class='t1xtt-x-x-109'>https://book.douban.com/subject/4219448/#</span></a>.
</p>
  </div>
