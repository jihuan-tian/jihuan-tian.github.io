---
layout: post
title: Example 1 in Section 22 of James Munkres Topology
date: 2019-02-09
categories: [math]
tags: [topology]
mathjax: true
---

**Example 1** Let $$X$$ be the subspace $$[0,1]\cup[2,3]$$ of $$\mathbb{R}$$, and let $$Y$$ be the subspace $$[0,2]$$ of $$\mathbb{R}$$. The map $$p: X \rightarrow Y$$ defined by

 $$
p(x)=\begin{cases}
x & \text{for}\; x \in [0,1],\\
x-1 & \text{for}\; x \in [2,3]
\end{cases}
$$ 

is a closed map thus a quotient map, but not open.

**Proof** (a) $$p$$ is surjective is obvious.

(b) Prove $$p$$ is continuous.

$$p$$ is a piecewise function comprised of two parts $$p_1 = x$$ with $$x \in [0,1])$$ and $$p_2=x-1$$ with $$x\in[2,3]$$. We extend the domains and ranges of $$p_1$$ and $$p_2$$ to $$\mathbb{R}$$ and obtain two continuous functions $$\tilde{p}_1$$ and $$\tilde{p}_2$$. According to Theorem 18.2 (d) and (e), as the restrictions of $$\tilde{p}_1$$ and $$\tilde{p}_2$$, $$p_1$$ and $$p_2$$ are continuous. Because $$X$$ comprises two disjoint parts $$[0,1]$$ and $$[2,3]$$, both of them are both open and closed in $$X$$. By treating them as open sets, according to Theorem 18.2 (f) the local formulation of continuity, $$p$$ is continuous. Or if we treat $$[0,1]$$ and $$[2,3]$$ as closed sets, according to Theorem 18.3 the pasting lemma, $$p$$ is also continuous.

**Comment** To prove the continuity of a piecewise function, it is very cumbersome if we start the proof from the raw definition of continuity, which will involve lots of cases for discussion. The appropriate way is to use Theorem 18.2 and Theorem 18.3, especially extensions and restriction of function's domain and range.

(c) Prove $$p$$ is a closed map, thus a quotient map.

It is obvious to see that $$\tilde{p}_1$$ is an identity map and $$\tilde{p}_2$$ is a merely a translation. Both of them are closed maps. For a closed set $$C$$ in $$X$$, there exists a closed set $$C'$$ in $$\mathbb{R}$$ such that $$C = C'\cap X$$. The image of $$C$$ under $$p$$ is

 $$
\begin{aligned}
p(C) &= p(C'\cap X) = p(C' \cap ([0,1] \cup [2,3])) \\
&= p\left( (C'\cap[0,1]) \cup (C'\cap[2,3]) \right) \\
&= p(C'\cap[0,1]) \cup p(C'\cap[2,3])
\end{aligned}.
$$ 

According to Theorem 17.2, both $$C'\cap[0,1]$$ and $$C'\cap[2,3]$$ are closed in $$\mathbb{R}$$. Meanwhile, we have $$p(C'\cap[0,1])=\tilde{p}_1(C'\cap[0,1])$$ and $$p(C'\cap[2,3])=\tilde{p}_2(C'\cap[2,3])$$, both of which are closed in $$\mathbb{R}$$ because $$\tilde{p}_1$$ and $$\tilde{p}_2$$ are closed maps. Because $$Y$$ is closed in $$\mathbb{R}$$, by applying Theorem 17.2 again,  $$p(C'\cap[0,1]) $$ and $$p(C'\cap[2,3])$$ are closed in $$Y$$, so is their union $$p(C)$$. Hence, $$p$$ is a closed map.

(d) Prove $$p$$ is not an open map.

$$[0,1]$$ is open in $$X$$ but $$p([0,1])=[0,1]$$, which is closed in $$Y$$. Therefore, $$p$$ is not an open map.
