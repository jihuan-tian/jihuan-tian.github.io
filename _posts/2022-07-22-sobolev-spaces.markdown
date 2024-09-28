---
layout: post
title: Summary of Sobolev spaces and their norms
date: 2022-07-22
categories: [math]
tags: [PDE,Sobolev-space]
mathjax: true
---

Norm of Sobolev space $$W_p^s(\Omega)$$

-   When $$s\geq 0$$

    -   When $$s\in\mathbb{N}_0$$, write it as $$k$$

         $$\norm{u}_{W_p^k(\Omega)} =
              \begin{cases}
                \displaystyle{\left( \sum_{\abs{\alpha}\leq k} \norm{D^{\alpha}u}_{L_p(\Omega)}^p
                  \right)^{\frac{1}{p}}} & p \in [1,\infty) \\
                \displaystyle{\max_{\abs{\alpha}\leq k} \norm{D^{\alpha}u}_{L_{\infty}(\Omega)}} & p = \infty
              \end{cases}$$ 


    -   When $$s > 0$$ and is fractional, let it be $$s=k+\kappa$$, with
        $$k=\lfloor s \rfloor$$ and $$\kappa\in(0,1)$$
        $$\norm{u}_{W_p^s(\Omega)} = \left( \norm{u}_{W_p^k(\Omega)}^p + \abs{u}_{W_p^s(\Omega)}^p \right)^{\frac{1}{p}}$$ 

        where $$\abs{u}_{W_p^s(\Omega)}$$ is the Sobolev-Slobodeckii
        semi-norm

         $$\abs{u}_{W_p^s(\Omega)}^p = \sum_{\abs{\alpha}=k}\int_{\Omega}\int_{\Omega}
              \frac{\abs{D^{\alpha}u(x) - D^{\alpha}u(y)}^p}{\abs{x-y}^{d+p\kappa}} \intd x \intd y$$ 


-   When $$s < 0$$ and $$p \in (1, \infty)$$

    -   $$W_p^s(\Omega) = \left( \overset{\circ}{W}_q^{-s} \right)'$$ with
        $$\frac{1}{p} +
            \frac{1}{q}=1$$. Then its norm is the operator norm
        $$\norm{u}_{W_p^s(\Omega)}=\sup_{0\neq v \in \overset{\circ}{W}_q^{-s}(\Omega)} \frac{\abs{\left\langle u,v \right\rangle_{\Omega}}}{\norm{v}_{\overset{\circ}{W}_q^{-s}(\Omega)}}$$ 
    -   $$\overset{\circ}{W}_p^s(\Omega) = \left( W_q^{-s}(\Omega) \right)'$$,
        its operator norm is
        $$\norm{u}_{\overset{\circ}{W}_p^s(\Omega)} = \sup_{0\neq v \in W_{q}^{-s}(\Omega)} \frac{\abs{\left\langle u,v \right\rangle_{\Omega}}}{\norm{v}_{W_q^{-s}(\Omega)}}$$ 


Generate Sobolev spaces by taking closure
-   $$W_p^s(\Omega) = \overline{C^{\infty}(\Omega)}^{\norm{\cdot}_{W_p^s(\Omega)}}$$
    with $$s \geq 0$$ and $$p \in [1, \infty]$$
-   $$\overset{\circ}{W}_p^s(\Omega) =
      \overline{C_0^{\infty}(\Omega)}^{\norm{\cdot}_{W_p^s(\Omega)}}$$
    with $$s \geq 0$$ and $$p \in [1,
      \infty]$$
-   $$\widetilde{H}^s(\Omega) = \overline{C_0^{\infty}(\Omega)}^{\norm{\cdot}_{H^s(\mathbb{R}^d)}}
      = \overline{C_0^{\infty}(\Omega)}^{\norm{\cdot}_{W_2^s(\mathbb{R}^d)}}$$
    with $$s\in \mathbb{R}$$
- \$$H_0^s(\Omega) = \overline{C_0^{\infty}(\Omega)}^{\norm{\cdot}_{H^s(\Omega)}}$$

Generate Sobolev spaces by taking restriction
- \$$H^s(\Omega) = \left\{ v=\widetilde{v}\vert_{\Omega}: \widetilde{v}\in H^s(\mathbb{R}^d) \right\}$$

Duality relation between Sobolev spaces
-   $$W_p^s(\Omega) = \left( \overset{\circ}{W}_q^{-s} \right)'$$ with
    $$s < 0$$ and $$p \in (1, \infty)$$
-   $$\overset{\circ}{W}_p^s(\Omega) = \left( W_q^{-s}(\Omega) \right)'$$
    with $$s < 0$$ and $$p \in
      (1, \infty)$$
-   $$\widetilde{H}^s(\Omega) = \left[ H^{-s}(\Omega) \right]'$$ for all
    $$s\in \mathbb{R}$$ when $$\Omega$$ is a Lipschitz domain
-   $$H^s(\Omega)=\left[ \widetilde{H}^{-s}(\Omega) \right]'$$ for all
    $$s\in \mathbb{R}$$ when $$\Omega$$ is a Lipschitz domain
-   $$H^s(\Gamma)=\left[ H^{-s}(\Gamma) \right]'$$ for $$s<0$$

Equivalent Sobolev spaces
-   $$H^s(\mathbb{R}^d) = W_2^s(\mathbb{R}^d)$$ for all $$s\in \mathbb{R}$$
-   $$H^s(\Omega)=W_2^s(\Omega)$$ for all $$s > 0$$ when $$\Omega$$ is a
    Lipschitz domain
-   $$\widetilde{H}^s(\Omega)=H_0^s(\Omega)$$ for $$s\geq 0$$ and
    $$s\neq \left\{
        \frac{1}{2},\frac{3}{2},\frac{5}{2}, \cdots \right\}$$, when
    $$\Omega$$ is a Lipschitz domain

{{ "2022-07-22-sobolev-spaces" | backlink }}
