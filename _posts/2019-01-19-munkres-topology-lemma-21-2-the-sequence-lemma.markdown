---
layout: post
title: The sequence lemma in James Munkres Topology
date: 2019-01-19
categories: [math]
tags: [topology]
mathjax: true
---

**Lemma 21.2 (The sequence lemma)** Let $$X$$ be a topological space; let $$A \subset X$$. If there is a sequence of points of $$A$$ converging to $$x$$, then $$x \in \bar{A}$$; the converse holds if $$X$$ is metrizable.

**Proof** a) Sequence convergence $$\Longrightarrow$$ the limit point belongs to $$\bar{A}$$.

Let $$\{x_n\}_{n \in \mathbb{Z_+}}$$ be a sequence of points in $$A$$. When $$n \rightarrow \infty$$, it converges to $$x$$ topologically in $$X$$. Then for all open set $$U$$ containing $$x$$, there exists an $$N \in \mathbb{Z_+}$$, such that when $$n > N$$, $$x_n \in U$$. Hence $$U \cap A \neq \Phi$$. According to Theorem 17.5 (a), $$x \in \bar{A}$$.

b) $$x$$ belongs to $$\bar{A}$$ and $$X$$ is metrizable $$\Longrightarrow$$ Sequence convergence to $$x$$.

Still according to Theorem 17.5 (a), when $$x \in \bar{A}$$, for all open set $$U$$ containing $$x$$, $$U \cap A \neq \Phi$$. However, this only ensures that the intersection is nonempty but is not enough to promise that there exists an $$N$$ in $$\mathbb{Z}_+$$, such that for all $$n > N$$, $$x_n$$ belongs to $$U$$. Hence, the desired convergence sequence in $$A​$$ does not necessarily exist.

If $$X​$$ is assigned a metric, a collection of nested open balls $$\left\{B_n(x, \frac{1}{n})\right\}_{n \in \mathbb{Z}_+}​$$ centered at $$x \in \bar{A}​$$ can be constructed. For all $$n \in \mathbb{Z}_+​$$, $$B_{n}(x, \frac{1}{n}) \cap A \neq \Phi​$$ and an element $$x_n​$$ can be selected from this intersection. Thus a sequence $$\{x_n\}_{n \in \mathbb{Z}_+}​$$ convergent to $$x​$$ is obtained.

**Remark**

1. As shown in b) above, a metric assigned to the space $$X$$ which generates the same topology as that used for defining sequence convergence is mandatory to ensure the existence of a convergent sequence to $$x$$.  This contradicts our common conception about the equivalence between the closeness of a set $$A$$ and the existence of a convergent sequence with its limit point within $$A$$. This is because the spaces we are dealing with in everyday life, such as Banach spaces, Hilbert spaces, have sound properties which have already included a well defined metric. However, when we come to the study of topology, such nice property is stripped away for the purpose of establishing a more abstract and general theory underpinning those high level and realistic topics.

2. It is natural for us to ask that if an example can be given, where the space $$X$$ has no associated metric and there is no sequence $$\{x_n\}_{n \in \mathbb{Z}_+}$$ in $$A$$ convergent to a point $$x \in \bar{A}$$.

   Let’s consider a set $$X = S_{\Omega} \cup \{\Omega\}$$ with $$S_{\Omega}$$ being the minimal uncountable well-ordered set as defined in Lemma 10.2. Let $$X$$ be assigned the order topology and let $$A = S_{\Omega}$$ be a subset of $$X$$. Because $$S_{\Omega}$$ is the largest element in $$X$$, any open set $$U$$ in $$X$$ containing $$\Omega$$ must have the form $$(x ,\Omega]$$ with $$x \in S_{\Omega}$$. Then it is obvious that $$U \cap S_{\Omega} \neq \Phi$$ and thus $$\Omega$$ belongs to $$\bar{S}_{\Omega}$$. More accurately speaking, $$\Omega$$ is a limit point of $$S_{\Omega}$$.

   Next, we show that there is no sequence $$\{x_n\}_{n \in \mathbb{Z}_+}$$ in $$S_{\Omega}$$ convergent to $$\Omega$$.

   Assume such sequence really exists. Because it is a countable set, according to Theorem 10.3, it has an upper bound $$x^*$$ in $$S_{\Omega}$$. We know from Lemma 10.2 that $$S_{\Omega}$$ is uncountable and the section $$S_{x^*}$$ is countable, therefore the set $$V = \{x \vert x \in S_{\Omega} \;\text{and}\; x > x^*  \}$$ is not empty. Then the open set $$(x^*, \Omega]$$ in $$X$$ containing $$\Omega$$ has an empty intersection with the sequence $$\{x_n\}_{n \in \mathbb{Z}_+}$$ in $$S_{\Omega}$$. Therefore, $$\{x_n\}_{n \in \mathbb{Z}_+}$$ is not convergent to $$\Omega$$.

3. The contrapositive of part b) in this lemma can be used to prove that a space with a certain topology is not metrizable, i.e. by showing that there exists an *abnormal* point $$x​$$  in the closure of $$A​$$, to which there is no convergent sequence in $$A​$$, we can prove that there is no metric for the space $$X​$$ which can induce the same topology as that used for defining the sequence convergence.

4. For all $$A \subset X$$ and for all $$x \in \bar{A}$$, if there is always a sequence in $$A$$ convergent to $$x$$, we still cannot assert that $$X$$ is metrizable.

   This can be verified by giving a counter example. Let $$X = \mathbb{R}$$ be given the finite complement topology, i.e. the space satisfies the $$T_1$$ axiom. Then for any $$A \subset X$$, if $$A$$ is a finite set, $$A$$ itself is closed. For all $$x \in \bar{A} = A$$, $$\{x_n = x\}_{n \in \mathbb{Z}_+}$$ is a sequence in $$A$$ convergent to $$x$$.

   If $$A$$ is an infinite set, $$\bar{A} = \mathbb{R}$$. This is because for all $$x \in \mathbb{R}$$ and for all open set $$U$$ in $$\mathbb{R}$$ containing $$x$$, its complement $$U^{\rm c}$$ is closed and is thus finite. Assume $$U \cap A = \Phi$$, then $$A \subset U^{\rm c}$$. However, because $$A$$ is infinite, it cannot be contained within the finite set $$U^{\rm c}$$. Therefore, $$U \cap A \neq \Phi$$ and it proves that for all $$x \in \mathbb{R}$$ it belongs to the closure of $$A$$. Hence $$\bar{A} = \mathbb{R}$$.

   Let $$\{x_n\}_{n \in \mathbb{Z}_+}​$$ be a sequence in $$A​$$ which has an infinite number of different elements. This is feasible because $$A​$$ itself is an infinite set. For all $$x \in \mathbb{R}​$$ and for all open set $$U​$$ in $$\mathbb{R}​$$ containing $$x​$$, its complement $$U^{\rm c}​$$ is a closed finite set. Then we consider following two complete cases.

   * If for all $$y \in U^{\rm c}$$, $$y \notin \{x_n\}_{n \in \mathbb{Z}_+}$$, we have $$\{x_n\}_{n \in \mathbb{Z}_+} \subset U$$, i.e. in the language of convergence, for all $$n >1 $$, $$x_n \in U​$$.
   * If there exists a finite subset $$V$$ of $$U^{\rm c}$$ such that $$V \subset \{x_n\}_{n \in \mathbb{Z}_+}$$ and let $$N$$ be the maximum index in the sequence for those elements in $$V$$, then for all $$n > N$$, $$x_n \in U$$.

   Therefore, the sequence $$\{x_n\}_{n \in \mathbb{Z}_+}$$ converges to $$x$$ in any of the above two cases.

   This conclusion can be restated as below.

   > Let $$\mathbb{R}$$ be assigned the finite complement topology. Any sequence $$\{x_n\}_{n \in \mathbb{Z}_+} \subset \mathbb{R}$$ having an infinite number of different elements can converge to any point $$x$$ in $$\mathbb{R}$$.

   Next, we need a small lemma to be proved:

   > Every topological space $$X​$$ with a metric $$d​$$ satisfies the Hausdorff axiom.

   **Proof** For all $$x, y \in X$$, let their distance be $$d(x, y) = \epsilon$$. Select an open ball $$B_d(x, \frac{\epsilon}{2})$$ and for all $$z \in B_d(x, \frac{\epsilon}{2})$$, we have $$d(x, y) \leq d(x, z) + d(z, y)$$ and thus $$d(z, y) \geq d(x, y) - d(x, z)$$. Because $$d(x, z) < \frac{\epsilon}{2}$$, $$d(z, y) > \epsilon - \frac{\epsilon}{2} = \frac{\epsilon}{2}$$. Hence $$z \notin B_d(y, \frac{\epsilon}{2})$$. Similarly, for all $$z \in B_d(y, \frac{\epsilon}{2})$$, $$z \notin B_d(x, \frac{\epsilon}{2})$$. Therefore, $$X$$ satisfies the Hausdorff axiom.

   Up to now, the conditions in the proposition of this part of the remark have been met. Because $$\mathbb{R}$$ with the finite complement topology only satisfies the $$T_1$$ axiom, which is a weaker condition than the Hausdorff axiom, according to the contrapositive of the above lemma, $$\mathbb{R}$$ is not metrizable.

{{ "2019-01-19-munkres-topology-lemma-21-2-the-sequence-lemma" | backlink }}
