---
layout: post
title: Prove a function space is a Banach space
date: 2022-03-25
categories: [math]
tags: [real-analysis]
mathjax: true
---

-   Assume the function space $$X$$ is assigned the norm $$\norm{\cdot}$$.
    Show that the definition of $$\norm{\cdot}$$ is really a norm, i.e.
    it should satisfy positive definiteness, scalar multiplication and
    triangle inequality.

-   $$(X,\norm{\cdot})$$ is a linear space, i.e. closeness of addition and
    scalar multiplication should be proved in the sense of finite norm.

-   Prove every Cauchy sequence in $$X$$ is convergent.

    -   Select a Cauchy sequence $$\left\langle u_n \right\rangle$$ in the
        function space $$X$$ and show that it converges to a function $$u$$
        pointwise. This is natural as long as the codomain of
        $$\left\langle u_n \right\rangle$$ which contain their actual
        ranges is complete, which can be ensured when the codomain is
        $$\mathbb{R}$$ or $$\mathbb{C}$$.

    -   Prove $$u \in X$$ in the sense of finite norm.

    -   Up to now, the convergence of $$u_n$$ to $$u$$ is still in the
        pointwise sense. Hence we still need to prove $$u_n$$ converges to
        $$u$$ in the norm assigned to $$X$$.
