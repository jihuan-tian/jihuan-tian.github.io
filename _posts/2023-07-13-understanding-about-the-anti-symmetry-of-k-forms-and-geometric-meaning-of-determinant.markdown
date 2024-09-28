---
layout: post
title: Understanding about the anti-symmetry of \(k \)-forms and geometric meaning of determinant
date: 2023-07-13
categories: [math]
tags: [differential-geometry,cmu-ddg,snippet]
mathjax: true
---

When applying a differential $$k$$-form
$$\alpha(x) = \alpha_1(x) \wedge \cdots \wedge \alpha_k(x)$$ to a
$$k$$-vector field $$u(x) = u_1(x) \wedge \cdots \wedge u_k(x)$$,
swapping any pair of component differential $$1$$-forms in the
$$k$$-form, i.e. $$(\alpha_i(x), \alpha_j(x))$$, or any pair of
component vectors in the $$k$$-vector field, i.e. $$(u_i(x), u_j(x))$$,
will change the sign of the resulted scalar value $$\alpha(u)$$. This is
because both the differential $$1$$-forms
$$\{\alpha_1(x), \cdots, \alpha_k(x)\}$$ in $$\alpha(x)$$ and the
vectors $$\{u_1(x), \cdots, u_k(x)\}$$ in $$u(x)$$ are ordered sets, the
permutation of which defines an orientation.

The resulted value $$\alpha(u)$$ is actually a determinant[^1]

$$
\alpha(u) = 
\begin{vmatrix}
\alpha_1(u_1) & \cdots & \alpha_1(u_k) \\
\vdots & \vdots & \vdots \\
\alpha_k(u_1) & \cdots & \alpha_k(u_k)
\end{vmatrix},
$$

where each column is a projection of one component
vector in $$u(x)$$ to the differential $$k$$-form. Also the determinant
itself is anti-symmetric, which is consistent with the rule for
evaluation of $$\alpha(u)$$. Therefore, the signed volume of the
parallelogram spanned by the set of projected component vectors
$$\left\{ (\alpha_1(u_i), \cdots, \alpha_k(u_i)) \right\}_{i=1}^{k}$$ is
the geometric meaning of determinant.

[^1]: The following display equation is wrapped around `\begin{equation*} ... \end{equation*}` for correct visualization in Emacs Org mode.

{{ 2023-07-13-understanding-about-the-anti-symmetry-of-k-forms-and-geometric-meaning-of-determinant | backlink }}
