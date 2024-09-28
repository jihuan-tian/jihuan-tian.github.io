---
layout: post
title: Discretization of bilinear forms in BEM
date: 2022-06-01
categories: [math]
tags: [BEM]
mathjax: true
---

For mixed boundary value Laplace problem with $$\Gamma=\Gamma_{\rm D}\cup\Gamma_{\rm N}$$, involved boundary integral operators are $$I, V, K, K', D$$. The corresponding bilinear forms are $$b_I, b_V, b_K, b_{K'}, b_D $$. The matrices for their discretization are $$\mathscr{I}, \mathscr{V}, \mathscr{K}, \mathscr{K'}, \mathscr{D} $$. Then the system equation to be solved is as below.

$$
\begin{equation}
\begin{pmatrix}
  -\mathscr{V} & \mathscr{K} \\ \mathscr{K}' & \mathscr{D} \end{pmatrix}
\begin{pmatrix}
  t \big\vert_{\Gamma_{\rm D}} \\ u \big\vert_{\Gamma_{\rm N}} \end{pmatrix}=
\begin{pmatrix}
  -\frac{1}{2}\mathscr{I} - \mathscr{K} & \mathscr{V} \\ \mathscr{-D} & \frac{1}{2}\mathscr{I} - \mathscr{K}' \end{pmatrix}
\begin{pmatrix}
  g_D \\ g_N \end{pmatrix}
\end{equation}
$$

The bilinear forms related to the left hand side matrix blocks are:

$$
\begin{equation}
\begin{aligned}
b_V: H^{-\frac{1}{2}+s}(\Gamma_{\rm D}) \times H^{-\frac{1}{2}+s}(\Gamma_{\rm D}) \rightarrow \mathbb{C}\\
b_K: H^{\frac{1}{2}+s}(\Gamma_{\rm N}) \times H^{-\frac{1}{2}+s}(\Gamma_{\rm D}) \rightarrow \mathbb{C}\\
b_{K'}: H^{-\frac{1}{2}+s}(\Gamma_{\rm D}) \times H^{\frac{1}{2}+s}(\Gamma_{\rm N}) \rightarrow \mathbb{C}\\
b_D: H^{\frac{1}{2}+s}(\Gamma_{\rm N}) \times H^{\frac{1}{2}+s}(\Gamma_{\rm N}) \rightarrow \mathbb{C}
\end{aligned}
\end{equation}
$$

For the first row of the equation, the test function space, corresponding to the rows, is $$H^{-\frac{1}{2}+s}(\Gamma_{\rm D}) $$, which should be the same as the test function space for the right hand side. For the second row of the equation, the test function space is $$H^{\frac{1}{2}+s}(\Gamma_{\rm N}) $$. The matrices $$\mathscr{V} $$ and $$\mathscr{D} $$ corresponding to $$b_V $$ and $$b_D $$ respectively are symmetric. The matrix symmetry requires both the function space and the spatial domain to be the same for the two components in a bilinear form.

On the right hand side, the two mass matrices $$\mathscr{I} $$ in the block matrix are actually different. We call them $$\mathscr{I}_1 $$ and $$\mathscr{I}_2 $$ from now on. The bilinear forms related to the matrix blocks on the right hand side are:

$$
\begin{equation}
\begin{aligned}
b_{I_1}:& H^{\frac{1}{2}+s}(\Gamma_{\rm D})\times H^{-\frac{1}{2}+s}(\Gamma_{\rm D}) \rightarrow \mathbb{C} \\
b_K:& H^{\frac{1}{2}+s}(\Gamma_{\rm D})\times H^{-\frac{1}{2}+s}(\Gamma_{\rm D}) \rightarrow \mathbb{C} \\
b_V:& H^{-\frac{1}{2}+s}(\Gamma_{\rm N}) \times H^{-\frac{1}{2}+s}(\Gamma_{\rm D}) \rightarrow \mathbb{C}\\
b_D:& H^{\frac{1}{2}+s}(\Gamma_{\rm D}) \times H^{\frac{1}{2}+s}(\Gamma_{\rm N}) \rightarrow \mathbb{C}\\
b_{I_2}:& H^{-\frac{1}{2}+s}(\Gamma_{\rm N})\times H^{\frac{1}{2}+s}(\Gamma_{\rm N}) \rightarrow \mathbb{C} \\
b_{K'}:& H^{-\frac{1}{2}+s}(\Gamma_{\rm N}) \times H^{\frac{1}{2}+s}(\Gamma_{\rm N}) \rightarrow \mathbb{C}
\end{aligned}
\end{equation}
$$

We can see $$\mathscr{I}_1 $$ and $$\mathscr{I}_2 $$ are not identity matrices. This further strengthens our understanding about the fact that they are mass matrices instead of identity matrices. Meanwhile, $$\mathscr{K} $$ on the right hand side is different from $$\mathscr{K} $$ on the left hand side. This also holds for $$\mathscr{K}' $$, $$\mathscr{V} $$ and $$\mathscr{D} $$. Moreover, $$\mathscr{V} $$ and $$\mathscr{D} $$ on the right hand side are not symmetric matrices.

{{ 2022-06-01-discretization-of-bilinear-forms | backlink }}
