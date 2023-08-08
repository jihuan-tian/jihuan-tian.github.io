---
layout: post
title: Formulation of complex structure
date: 2023-08-08
categories: [math]
tags: [differential-geometry,cmu-ddg,snippet]
mathjax: true
---

In the [CMU DDG course](https://youtu.be/FRvhgkGKfSM?list=PL9_jI1bdZmz0hIrNCMQW1YmZysAiIYSSS&t=2762), the symbol adopted for the complex structure, i.e. the operation for rotating by $$\frac{\pi}{2} $$ should be $$\mathcal{J} $$ instead of $$\mathcal{J}_f $$. The latter should be the Jacobian matrix, which satisfies $$df(X) = \mathcal{J}_f X $$.

Then according to the definition of complex structure:

$$
 df(\mathcal{J} X) := N \times df(X), 
$$

the left hand side is equal to $$\mathcal{J}_f \mathcal{J} X $$ and the right hand side is equal to $$\hat{N} \mathcal{J}_f X $$. Multiply both sides by $$\mathcal{J}_f^T $$

$$
 \mathcal{J}_f^T \mathcal{J}_f \mathcal{J} X = \mathcal{J}_f^T \hat{N} \mathcal{J}_f X. 
$$

Since $$X $$ is arbitrary, we have

$$
 \mathcal{J} = \left( \mathcal{J}_f^T \mathcal{J}_f \right)^{-1} \left( \mathcal{J}_f^T \hat{N} \mathcal{J}_f \right). 
$$
