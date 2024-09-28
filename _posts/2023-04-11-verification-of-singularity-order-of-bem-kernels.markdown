---
layout: post
title: Verification of singularity order of BEM kernels
date: 2022-08-27
categories: [math]
tags: [BEM]
mathjax: true
---

According to (Erichsen and Sauter 1998), kernel functions in BEM are
Gâteaux derivatives of the fundamental solution of the underlying
boundary value problem. For elliptic boundary value problems, a kernel
function $$k(x,y)$$ has the general form

$$
k(x,y)=\sum_{\abs{\alpha}=t}^{t+a} S_{\alpha}(x,y)\eta_{\alpha}(\norm{x-y})\frac{(y-x)^{\alpha}}{\norm{y-x}^{\sigma+t}},
$$

where $$S_{\alpha}: \Gamma\times\Gamma \rightarrow \mathbb{C}$$ are
analytic on each pair of smooth surface patches of $$\Gamma$$. The
scalar function $$\eta_{\alpha}$$ is also analytic.
$$\alpha\in \mathbb{N}_0^3$$ is a multi-index and $$\sigma$$ is defined
as the singularity order of $$k(x,y)$$.

When $$\sigma\leq 2$$, the kernel has Cauchy singularity. This means the
integral formed with this kernel exists in the sense of Cauchy principal
value, which can be evaluated by first removing an open ball
$$B_{\varepsilon}(x_0)$$ around the singular point $$x_0$$ from the
integration domain and then taking the limit
$$\varepsilon \rightarrow 0$$. When $$\sigma>2$$, the kernel is
hyper-singular, which should be regularized by introducing surface curl
and integration by parts (Steinbach 2007).

For 3D Laplace problem, the kernel for the single layer potential is

$$
U^{*}(x,y)=\frac{1}{4\pi\norm{x-y}}.
$$

 By letting $$t=0$$, $$a=0$$,
$$\sigma=1$$, $$\alpha=(0,0,0)$$,
$$S_{\alpha}(x,y)\cdot\eta_{\alpha}(\norm{y-x})=\frac{1}{4\pi}$$, this
kernel can be obtained by evaluating the general form. Therefore, the
singularity order of the single layer potential kernel is 1.

The double layer potential kernel is

$$
K(x,y)=\gamma_{1,y}^{\rm int}U^{*}(x,y)=\frac{n(y)\cdot(x-y)}{4\pi \norm{x-y}^3},
$$

where $$\gamma_{1,y}^{\rm int}$$ is the interior conormal derivative
operator. It can be derived from the general form with $$\sigma=2$$,
$$t=1$$, $$a=0$$, $$\alpha_1=(1,0,0)$$, $$\alpha_2=(0,1,0)$$,
$$\alpha_3=(0,0,1)$$ and 

$$
\begin{aligned}
S_{\alpha_1}(x,y)\cdot\eta_{\alpha_1}(\norm{y-x}) &= -\frac{n_1(y)}{4\pi} \\
S_{\alpha_2}(x,y)\cdot\eta_{\alpha_2}(\norm{y-x}) &= -\frac{n_2(y)}{4\pi} \\
S_{\alpha_3}(x,y)\cdot\eta_{\alpha_3}(\norm{y-x}) &= -\frac{n_3(y)}{4\pi} \\
\end{aligned}.
$$

 Hence, the singularity order of the double layer
potential kernel is 2.

Similarly, for the adjoint double layer potential kernel


$$
K^{*}(x,y)=\gamma_{1,x}^{\rm int}U^{*}(x,y)=\frac{n(x)\cdot(y-x)}{4\pi \norm{x-y}^3},
$$

let 

$$
\begin{aligned}
S_{\alpha_1}(x,y)\cdot\eta_{\alpha_1}(\norm{y-x}) &= \frac{n_1(x)}{4\pi} \\
S_{\alpha_2}(x,y)\cdot\eta_{\alpha_2}(\norm{y-x}) &= \frac{n_2(x)}{4\pi} \\
S_{\alpha_3}(x,y)\cdot\eta_{\alpha_3}(\norm{y-x}) &= \frac{n_3(x)}{4\pi} \\
\end{aligned},
$$

 while keeping other parameters fixed, we can see its
singularity order is still 2.

For the hyper-singular potential kernel,

$$
D(x,y)=-\gamma_{1,x}^{\rm int}\gamma_{1,y}^{\rm int}U^{*}(x,y)=\frac{1}{4\pi} \left[ -\frac{n(x) \cdot n(y)}{r^3} + \frac{3[n(y) \cdot (x - y)] [n(x) \cdot (x -y)]}{r^5} \right],
$$

we notice that the term $$[n(y) \cdot (x - y)] [n(x) \cdot (x -y)]$$ can
be expanded as 

$$
\begin{aligned}
[n(y) \cdot (x - y)] [n(x) \cdot (x -y)] &= n_1(x)n_1(y)(x_1-y_1)^2 + n_2(x)n_2(y)(x_2-y_2)^2 + n_3(x)n_3(y)(x_3-y_3)^2 \\
&\quad + \left[ n_1(x)n_2(y) + n_2(x)n_1(y) \right](x_1-y_1)(x_2-y_2) \\
&\quad + \left[ n_1(x)n_3(y) + n_3(x)n_1(y) \right](x_1-y_1)(x_3-y_3) \\
&\quad + \left[ n_2(x)n_3(y) + n_3(x)n_2(y) \right](x_2-y_2)(x_3-y_3).
\end{aligned}
$$

 This prompts us to define $$\alpha_1=(2,0,0)$$,
$$\alpha_2=(0,2,0)$$, $$\alpha_3=(0,0,2)$$, $$\alpha_4=(1,1,0)$$,
$$\alpha_5=(1,0,1)$$, $$\alpha_6=(0,1,1)$$ and 

$$
\begin{aligned}
S_{\alpha_1}(x,y)\cdot\eta_{\alpha_1}(\norm{y-x}) &= -\frac{n(x)\cdot n(y)}{4\pi} + \frac{3n_1(x)n_1(y)}{4\pi}\\
S_{\alpha_2}(x,y)\cdot\eta_{\alpha_2}(\norm{y-x}) &= -\frac{n(x)\cdot n(y)}{4\pi} + \frac{3n_2(x)n_2(y)}{4\pi}\\
S_{\alpha_3}(x,y)\cdot\eta_{\alpha_3}(\norm{y-x}) &= -\frac{n(x)\cdot n(y)}{4\pi} + \frac{3n_3(x)n_3(y)}{4\pi}\\
S_{\alpha_4}(x,y)\cdot\eta_{\alpha_4}(\norm{y-x}) &= \frac{3[n_1(x)n_2(y)+n_2(x)n_1(y)]}{4\pi}\\
S_{\alpha_5}(x,y)\cdot\eta_{\alpha_5}(\norm{y-x}) &= \frac{3[n_1(x)n_3(y)+n_3(x)n_1(y)]}{4\pi}\\
S_{\alpha_6}(x,y)\cdot\eta_{\alpha_6}(\norm{y-x}) &= \frac{3[n_2(x)n_3(y)+n_3(x)n_2(y)]}{4\pi}\\
\end{aligned}.
$$

Then the kernel function can be derived from the general form with
$$\sigma=3$$, $$t=2$$, $$a=0$$. Hence, the singularity order of the
hyper-singular potential kernel is 3.

# References

<div id="refs" class="references hanging-indent">

<div id="ref-ErichsenEfficient1998" markdown="1">

Erichsen, Stefan, and Stefan A. Sauter. 1998. “Efficient Automatic
Quadrature in 3-d Galerkin Bem.” *Computer Methods in Applied Mechanics and Engineering*, Papers presented at the seventh conference on
numerical methods and computational mechanics in science and
engineering, 157 (3): 215–24.
<https://doi.org/10.1016/S0045-7825(97)00236-3>.

</div>

<div id="ref-SteinbachNumerical2007" markdown="1">

Steinbach, Olaf. 2007. *Numerical Approximation Methods for Elliptic Boundary Value Problems: Finite and Boundary Elements*. Springer Science
& Business Media.

</div>

</div>

{{ 2023-04-11-verification-of-singularity-order-of-bem-kernels | backlink }}
