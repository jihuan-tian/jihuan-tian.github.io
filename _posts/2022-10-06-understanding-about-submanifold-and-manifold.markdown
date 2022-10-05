---
layout: post
title: Understanding about submanifold and manifold
date: 2022-10-06
categories: [math]
tags: [differential-geometry]
mathjax: true
---

For any point $$p$$ of a submanifold $$M$$ in an Euclidean space $$\mathbb{R}^{n+r}$$, it is already assigned the global coordinates in $$\mathbb{R}^{n+r}$$. Here $$\mathbb{R}^{n+r}$$ plays the role of the absolute space-time proposed by Newton. Then, the submanifold $$M$$ is defined as: for each point $$p$$ in $$M$$, there exists a neighborhood $$U$$, where $$r$$ coordinate components can be differentiably represented by the remaining $$n$$ components. Therefore, these remaining coordinate components are indepedent, the number of which is the dimension of the submanifold $$M$$.

Another understanding about submanifold is not based on the above **explicit** representation of some $$r$$ coordinate components by the $$n$$ independent components, but is described as the common locus of a set of constraint functions $$F(x)=0$$ or $$F(x)=t$$, where 0 or $$t$$ belongs to $$\mathbb{R}^{r}$$ and there are $$r$$ equations in the system. Then we need to check the Jacobian matrix of the map $$F(x)$$. If it has rank $$r$$, $$M$$ is a $$n$$-dimensional submanifold in $$\mathbb{R}^{n+r}$$. With the help of implicit function theorem, this definition is equivalent to the first one.

For the definition of a manifold $$M$$, the global Euclidean space is not mandatory and the absolute space-time notion is abandoned. Instead, it relies on two points. Assume there is an open covering of $$M$$,

1.  for each open set $$U$$ in this covering, there is a one-to-one correspondence between $$U$$ and an open set in $$\mathbb{R}^{n}$$. N.B. At the moment, we only have this local bijection, but not a homeomorphism, since no topology has been constructed yet. In this way, each open set in the covering of $$M$$ is assigned a coordinate chart.
2.  The coordinate transformation between any pair of these coordinate charts is differentiable.

The definition of a submanifold $$M^r$$ in the manifold $$M^n$$ is similar to that for the submanifold in an Euclidean space. But now there is no **global** coordinate frame any more, but only a collection of **local** coordinate charts on $$M^n$$. For each point $$p$$ in $$M^r$$, it must be contained in an open set $$U$$ in the open covering of $$M^n$$, which is assigned a local coordinate chart. With respect to this chart, $$U \cap M^r$$ can be represented as a locus by a system of constraints, the Jacobian matrix of which has rank $$n-r$$. Or in another way, $$n-r$$ coordinate components can be locally and differentiably represented by the remaining $$r$$ coordinate components.
