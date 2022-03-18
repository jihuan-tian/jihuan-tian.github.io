---
layout: post
title: Barber paradox
date: 2018-12-12
categories: [math]
tags: [set-theory]
mathjax: true
disqus: y
---

According to [Wikipedia](https://en.wikipedia.org/wiki/Barber_paradox?wprov=sfti1), the well known barber paradox states like this:

> The barber is the “one who shaves all those, and those only, who do not shave themselves.” The question is, does the barber shave himself?

Actually, this paradox is directly related to the second part of Theorem 7.8 in James Munkres “Topology”. This theorem says:

> Let $A$ be a set. There is no injective map $f: \mathcal{P}(A) \rightarrow A$, and there is no surjective map $g: A \rightarrow \mathcal{P}(A)$.

Here $\mathcal{P}(A)$ represents the power set of $A$.

Mapped to the barber paradox, this theorem can be dissected as below:

Let the set $A$ represent all the people involved in the paradox. Let $a$ be any one of the barbers and the surjective map $g$ associate $a$ with a group of people $C \in \mathcal{P}(A)$, who do not shave themselves and are $a$’s customers. Then, let $B$ be a subset of $A$ including all the barbers. Because $g$ is surjective, this group of barbers $B$ must also have its own pre-image, which is a singleton $\{a_0\}$ in $A$. According to the definition of $g$, all the barbers in group $B$ do not shave themselves and the only people $a_0$ in the singleton is also a barber who provides service to all barbers in $B$. And here we have the paradox: on one hand, because the barber $a_0$ belongs to the subset $B$ so $a_0$ does not shave himself; on the other hand, the rule of assignment for the surjective map $g$ ensures $a_0$ really shaves himself.

Although we have an unsolvable paradox here, there is no need to bear any qualms. In reality, the barbers in $B$ do not need a high-level **barber’s barber** or a barber from another city as the $a_0$. They can simply provide mutual help to each other.
