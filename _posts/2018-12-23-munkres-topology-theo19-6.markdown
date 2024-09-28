---
layout: post
title: Theorem 19.6 in James Munkres Topology
date: 2018-12-23
categories: [math]
tags: [topology]
mathjax: true
---

**Theorem 19.6** Let $$f: A \rightarrow \prod_{\alpha \in J} X_{\alpha}$$ be given by the equation


 $$
f(a) = (f_{\alpha}(a))_{\alpha \in J},
$$ 


where $$f_{\alpha}: A \rightarrow X_{\alpha}$$ for each $$\alpha$$. Let $$\prod X_{\alpha}$$ have the product topology. Then the function $$f$$ is continuous if and only if each function $$f_{\alpha}$$ is continuous.

**Comment:** This is an extension of Theorem 18.4, where only two component spaces are involved.

**Proof:** a) First, we prove the projection map is continuous, which is defined on the Cartesian space constructed from a $$J$$-tuple of component spaces .

For all $$\beta \in J$$, let $$\pi_{\beta}: \prod X_{\alpha} \rightarrow X_{\beta}$$ be the projection map. For arbitrary open set $$V_{\beta}$$ in $$X_{\beta}$$, its pre-image under $$\pi_{\beta}$$ is $$\pi_{\beta}^{-1}(V_{\beta})$$, which is a subbasis element for the product topology on $$\prod X_{\alpha}$$. Therefore, $$\pi_{\beta}^{-1}(V_{\beta})$$ is open and the projection map $$\pi_{\beta}$$ is continuous.

Next, we notice that for all $$\alpha \in J$$, the coordinate function $$f_{\alpha}: A \rightarrow X_{\alpha}$$ is a composition of the two continuous functions $$f$$ and $$\pi_{\alpha}$$, i.e. $$f_{\alpha} = \pi_{\alpha} \circ f$$. Then according to Theorem 18.2 (c), $$f_{\alpha}$$ is continuous.

**Remark:** Because the box topology is finer than the product topology, the projection map is also continuous when the box topology is adopted for $$\prod X_{\alpha}$$. Therefore, this part of the theorem is true for both product topology and box topology.

b) **Analysis:** To prove the continuity of a function, showing that the pre-image of any subbasis element in the range space is open in the domain space is more efficient than using basis element or *raw* open set in the range space. In addition, the subbasis element for the product topology on $$\prod X_{\alpha}$$ has the form $$\pi_{\beta}^{-1}(U_{\beta})$$ with $$U_{\beta}$$ being a single coordinate component and open in $$X_{\beta}$$. This is the clue of the proof.

For all $$\beta \in J$$ and arbitrary open set $$U_{\beta}$$ in $$X_{\beta}$$, we have $$f_{\beta}^{-1}(U_{\beta}) = f^{-1} \circ \pi_{\beta}^{-1}(U_{\beta})$$. Because $$f_{\beta}$$ is continuous and $$U_{\beta}$$ is open, $$f_{\beta}^{-1}(U_{\beta})$$ is open. In addition, $$\pi_{\beta}^{-1}(U_{\beta})$$ is an arbitrary subbasis element for $$\prod X_{\alpha}$$ with the product topology, whose pre-image under $$f$$ is just the open set $$f_{\beta}^{-1}(U_{\beta})$$, therefore $$f$$ is continuous.

**Remark:** Part b) of this theorem really depends on the adopted topology for $$\prod X_{\alpha}$$, which can be understood as below.

At first, we will show that for all $$\vect{U} = \prod U_{\alpha}$$ being a subset of $$\prod X_{\alpha}$$, $$f^{-1}(\vect{U}) = \bigcap_{\alpha \in J} f_{\alpha}^{-1}(U_{\alpha})$$.

For all $$x \in f^{-1}(\vect{U})$$, because $$f(x) \in \vect{U}$$, then for all $$\alpha \in J$$, $$f_{\alpha}(x) \in U_{\alpha}$$, hence $$x \in \bigcap_{\alpha \in J} f_{\alpha}^{-1}(U_{\alpha})$$ and $$f^{-1}(\vect{U}) \subset \bigcap_{\alpha \in J} f_{\alpha}^{-1}(U_{\alpha})$$.

On the other hand, for all $$x \in \bigcap_{\alpha \in J} f_{\alpha}^{-1}(U_{\alpha})$$, we have for all $$\alpha \in J$$, $$f_{\alpha}(x) \in U_{\alpha}$$. Therefore, $$f(x) \in \vect{U}$$ and $$x \in f^{-1}(\vect{U})$$. Hence $$\bigcap_{\alpha \in J} f_{\alpha}^{-1}(U_{\alpha}) \subset f^{-1}(\vect{U})$$.

Next, if we assign the product topology to $$\prod X_{\alpha}$$, for any $$\vect{U} = \prod U_{\alpha}$$ with $$U_{\alpha}$$ open in $$X_{\alpha}$$ and only a finite number of them not equal to $$X_{\alpha}$$, it is a basis element of the product topology. Let the set of all indices with which $$U_{\alpha} \neq X_{\alpha}$$ be $$\{\alpha_1, \cdots, \alpha_n\}$$ and also notice that when $$U_{\alpha} = X_{\alpha}$$, $$f_{\alpha}^{-1}(U_{\alpha}) = A$$, we have


 $$
f^{-1}(\vect{U}) = \bigcap_{\alpha \in J} f_{\alpha}^{-1}(U_{\alpha}) = \bigcap_{i=1}^n f_{\alpha_i}^{-1}(U_{\alpha_i}),
\tag{*}
\label{eq:intersection}
$$ 


where those $$f_{\alpha}^{-1}(U_{\alpha})$$ with $$\alpha \notin \{\alpha_1, \cdots, \alpha_n\}$$ do not contribute to the intersection. This indicates that $$f^{-1}(\vect{U})$$ is a finite intersection of open sets which is still open. Hence $$f$$ is continuous.

However, if the box topology is adopted for $$\prod X_{\alpha}$$, qualitatively speaking, because the topology for the range space becomes finer, according to our [previous post](https://www.cnblogs.com/peabody/p/10125356.html), it makes a function to be continuous more difficult. Specifically in this theorem, $$f^{-1}(\vect{U})$$ in \eqref{eq:intersection} can be an intersection of infinite number of open sets $$U_{\alpha}$$ not equal to $$X_{\alpha}$$. Thus $$f^{-1}(\vect{U})$$ may not be open anymore.

After understanding this point, it is not difficult to construct a counter example for part b) as below.

Let $$f: \mathbb{R} \rightarrow \mathbb{R}^{\omega}$$ be defined as $$f(t) = (t, t, \cdots)$$. Select a basis element $$\vect{U}$$ in $$\mathbb{R}^{\omega}$$ such that the intersection of all its coordinate components is not open. For example, $$\vect{U} = \prod_{n=1}^{\infty} (-\frac{1}{n}, \frac{1}{n})$$, which is a neighborhood of $$f(0) = (0, 0, \cdots)$$.

For any basis element $$(a, b)$$ in $$\mathbb{R}$$ containing $$0$$, with $$a < 0$$ and $$b > 0$$, by letting $$\delta = \min\{-a, b\}$$, we have $$(-\delta, \delta) \subset (a, b)$$ and $$0 \in (-\delta, \delta)$$. The image of $$(-\delta, \delta)$$ under $$f$$ is $$\prod_{n=1}^{\infty} (-\delta, \delta)$$. Then there exist an $$n_0 \in \mathbb{Z}_+$$ such that $$(-\delta, \delta)$$ is not contained in $$(-\frac{1}{n_0}, \frac{1}{n_0})$$. Therefore, $$\pi_{n_0}(f((-\delta, \delta)))$$ is not contained in $$\pi_{n_0}(\vect{U})$$ and $$\pi_{n_0}(f((a, b)))$$ is not contained in $$\pi_{n_0}(\vect{U})$$. Hence the image of $$(a, b)$$ under $$f$$ is not contained in $$\vect{U}$$. This contradicts Theorem 18.1 (4) and $$f$$ is not continuous.

{{ "2018-12-23-munkres-topology-theo19-6" | backlink }}
