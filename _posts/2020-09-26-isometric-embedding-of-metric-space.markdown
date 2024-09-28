---
layout: post
title: Isometric embedding of metric space
date: 2020-09-26
categories: [math]
tags: [real-analysis]
mathjax: true
---



This post summarizes the proof for Theorem 7.9 in Royden's "Real Analysis".

**Theorem 9** If $$\langle X, \rho \rangle$$ is an incomplete metric space, it is possible to find a complete metric space $$X^*$$ in which $$X$$ is isometrically embedded as a dense subset. If $$X$$ is contained in an arbitrary complete space $$Y$$, then $$X^*$$ is isometric with the closure of $$X$$ in $$Y$$.

**Analysis:** The proof about the completion of $$X$$ is not straightforward because this problem is given in an abstract way that there is nothing to manipulate or we cannot construct a specific example as the completion of $$X$$ for facilitating our understanding. Hence a new structure must be introduced to fulfill this purpose, which is the set of equivalence classes $$X^*$$ derived from the collection of all Cauchy sequences in $$X$$. Then it is to be proved that $$X$$ is identified with $$F(X)$$ in $$X^*$$, where $$F$$ is an isometry from $$X$$ to $$F(X)$$ and $$F(X)$$ is dense in $$X^*$$.

The proof of this theorem is divided into 5 steps as suggested by Exercise 17.

1. If $$\{x_n\}_{n \geq 1}$$ and $$\{y_n\}_{n \geq 1}$$ are Cauchy sequences from a metric space $$X$$, then $$\{\rho(x_n, y_n)\}_{n \geq 1}$$ converges.

   **Proof:** Because $$\langle X, \rho \rangle$$ is an incomplete space, the two sequences $$\{x_n\}_{n \geq 1}$$ and $$\{y_n\}_{n \geq 1}$$ do not necessarily have their limits within $$X$$. However, this proposition indicates that the inter-distance between $$x_n$$ and $$y_n$$ does converge when $$n$$ approaches to $$\infty$$.

   Because $$\rho(x_n, y_n) \in \mathbb{R}$$ and $$\mathbb{R}$$ is complete, to prove $$\{\rho(x_n, y_n)\}_{n \geq 1}$$ converges, we need to show that it is a Cauchy sequence.

   From the given condition, for any $$\varepsilon > 0$$, there exists $$N \in \mathbb{N}$$ such that when $$m_1, m_2 > N$$, $$\abs{x_{m_1} - x_{m_2}} < \frac{\varepsilon}{2}$$ and when $$n_1, n_2 > N$$, $$\abs{y_{n_1} - y_{n_2}} < \frac{\varepsilon}{2}$$.

   For any $$m, n > N$$,

   $$
   \abs{\rho(x_n, y_n) - \rho(x_m ,y_m)} = \abs{\rho(x_n, y_n) - \rho(x_n, y_m) + \rho(x_n, y_m) - \rho(x_m, y_m)}.
   $$

   Due to the triangle inequality satisfied by the metric $$\rho$$, we have

   $$
   \rho(x_n, y_n) \leq \rho(x_n, y_m) + \rho(y_m, y_n)
   $$

   and

   $$
   \rho(x_n, y_m) \leq \rho(x_n, y_n) + \rho(y_n, y_m).
   $$

   Hence,

   $$
   \rho(x_n, y_n) - \rho(x_n, y_m) \leq \rho(y_m, y_n)
   $$

   and

   $$
   \rho(x_n, y_m) - \rho(x_n, y_n) \leq \rho(y_m, y_n),
   $$

   which is actually

   $$
   \abs{\rho(x_n, y_n) - \rho(x_n, y_m)} \leq \rho(y_m, y_n).
   $$

   This is just a variation of the triangle inequality for a metric which says that the difference between the lengths of two edges of a triangle is smaller than or equal to the length of the third edge. Similarly, we have

   $$
   \abs{\rho(x_n, y_m) - \rho(x_m, y_m)} \leq \rho(x_m, x_n).
   $$

   Then

   $$
   \begin{aligned}
   \abs{\rho(x_n, y_n) - \rho(x_m, y_m)} &= \abs{\rho(x_n, y_n) - \rho(x_n, y_m) + \rho(x_n, y_m) - \rho(x_m, y_m)} \\
   & \leq \abs{\rho(x_n, y_n) - \rho(x_n, y_m)} + \abs{\rho(x_n, y_m) - \rho(x_m, y_m)} \\
   & \leq \rho(y_m, y_n) + \rho(x_m, x_n) \\
   & < \frac{\varepsilon}{2} + \frac{\varepsilon}{2} \\
   & = \varepsilon.
   \end{aligned}
   $$

   Therefore, $$\{\rho(x_n, y_n)\}_{n \geq 1}$$ is a Cauchy sequence in $$\mathbb{R}$$ and converges to some $$a$$ in $$\mathbb{R}$$.
   
2. The set of all Cauchy sequences from a metric space $$X$$ becomes a pseudometric space if $$\rho^*(\{x_n\}_{n \geq 1}, \{y_n\}_{n \geq 1}) = \lim_{n \rightarrow \infty} \rho(x_n, y_n)$$

   **Proof:** Because $$\{\rho(x_n, y_n)\}_{n \geq 1}$$ is convergent, the above definition of $$\rho^*(\{x_n\}_{n \geq 1}, \{y_n\}_{n \geq 1})$$ is meaningful. It can be verified that $$\rho^*$$ satisfies the conditions of positiveness, symmetry and triangle inequality, which are derived from those of $$\rho$$. Then we only need to find two different Cauchy sequences, the distance between which is zero, so that $$\rho^*$$ is a pseudometric.

   Let $$\{z_k\}_{k \geq 1}$$ be a Cauchy sequence. Let $$x_n = z_{2n-1}$$ and $$y_n = z_{2n}$$. Then $$\{x_n\}_{n \geq 1}$$ and $$\{y_n\}_{n \geq 1}$$ are two different Cauchy sequences with $$\rho^*(\{x_n\}_{n \geq 1}, \{y_n\}_{n \geq 1}) = \lim_{n \rightarrow \infty} \rho(x_n, y_n) = 0$$. Therefore, $$\rho^*$$ defined on the collection of all Cauchy sequences in $$X$$ is a pseudometric.

3. This pseudometric space becomes a metric space $$X^*$$ when we identify elements for which $$\rho^* = 0$$ and $$X$$ is isometrically embedded in $$X^*$$.

   **Proof:** According to Exercise 3 in Section 1, by letting $$R := \{\rho^*(\{x_n\}_{n \geq 1}, \{y_n\}_{n \geq 1}) = 0\}$$ be the equivalence condition on the set of all Cauchy sequences in $$X$$, the obtained collection of equivalence classes $$X^*$$ is a metric space. This can be verified as below.

   Let $$\mathcal{X}$$ and $$\mathcal{Y}$$ be two different equivalence classes in $$X^*$$. Let $$x_0$$ be the representative element of $$\mathcal{X}$$ and $$y_0$$ be that of $$\mathcal{Y}$$. Then for any $$x$$ in $$\mathcal{X}$$ and any $$y$$ in $$\mathcal{Y}$$, we have $$\rho^*(x, y) = \rho^*(x_0, y_0) = \rho^*(\mathcal{X}, \mathcal{Y}) \geq 0$$. If $$\rho^*(\mathcal{X}, \mathcal{Y}) = 0$$, $$\rho^*(x_0, y_0) = 0$$ and for any $$y$$ in $$\mathcal{Y}$$, $$\rho^*(x_0, y) = 0$$. Because of the equivalence relation $$R$$, $$y$$ belongs to $$\mathcal{X}$$. Similarly, for any $$x$$ in $$\mathcal{X}$$, $$x$$ belongs to $$\mathcal{Y}$$. Therefore, $$\rho^*(\mathcal{X}, \mathcal{Y}) = 0$$ implies $$\mathcal{X} = \mathcal{Y}$$. On the other hand, when $$\mathcal{X} = \mathcal{Y}$$, $$\rho^*(\mathcal{X}, \mathcal{Y}) = \rho^*(x_0, x_0) = 0$$. So $$\rho^*$$ has the property of positive definitiveness.

   The commutativity of $$\rho^*$$ is obvious, which is derived from that of $$\rho$$.
   
   Finally, for $$\mathcal{X}$$, $$\mathcal{Y}$$, $$\mathcal{Z}$$ in $$X^*$$ with their respective representative elements $$x_0$$, $$y_0$$ and $$z_0$$, $$\rho(\mathcal{X}, \mathcal{Y}) = \rho(x_0, y_0)$$, $$\rho(\mathcal{X}, \mathcal{Z}) = \rho(x_0, z_0)$$ and $$\rho(\mathcal{Z}, \mathcal{Y}) = \rho(z_0, y_0)$$. Because $$\rho(x_0, y_0) \leq \rho(x_0, z_0) + \rho(z_0, y_0)$$, we have the triangle inequality for $$\rho^*$$. Therefore, $$X^*$$ with $$\rho^*$$ is a metric space.
   
   Next, let $$F: X \rightarrow X^*$$ which associates each $$x$$ in $$X$$ with the equivalence class in $$X^*$$ that contains the Cauchy sequence $$\{x, x, \cdots\}$$. It is easy to see that for any $$x$$, $$y$$ in $$X$$,

   $$
   \rho^*(F(x), F(y)) = \rho^*(\{x, x, \cdots \}, \{y, y, \cdots\}) = \lim_{n \rightarrow \infty} \rho(x, y) = \rho(x, y).
   $$

   Meanwhile, if $$F(x) = F(y)$$, we have $$\rho^*(F(x), F(y)) = \rho(x, y) =\rho(x, x) = 0$$. Because $$\rho$$ is a standard metric, $$x = y$$. Hence, $$F$$ is injective. For any open ball $$B(\{x, x, \cdots\}, \varepsilon)$$ with a radius $$\varepsilon$$ in $$F(X)$$, its inverse image under $$F^{-1}$$ is $$B(x, \varepsilon)$$ in $$X$$, which is open in $$X$$. Then $$F$$ is a continuous map. Similarly, $$F^{-1}$$ is also continuous. Therefore, $$F$$ is a homeomorphism between $$X$$ and $$F(X)$$. Moreover, because $$\rho^*(F(x), F(y)) = \rho(x, y)$$, $$F$$ is an isometry.
   
   Then, we will prove $$X$$ is isometrically embedded in $$X^*$$ as a dense subset.
   
   Let $$B(\{x_n\}_{n \geq 1}, \varepsilon)$$ be an open ball in $$X^*$$, which is centered at an arbitrary element $$\{x_n\}_{n \geq 1}$$ in $$X^*$$. Because $$\{x_n\}_{n \geq 1}$$ is a Cauchy sequence, there exists $$N$$ in $$\mathbb{N}$$ such that when $$m, n > N$$, $$\abs{x_m - x_n} < \varepsilon$$. Then $$\rho^*(\{x_n\}_{n \geq 1}, \{x_m, x_m, \cdots\}) = \lim_{n \rightarrow \infty} \abs{x_n - x_m} < \varepsilon$$. Hence $$\{x_m, x_m, \cdots\}$$ belongs to $$B(\{x_n\}_{n \geq 1}, \varepsilon)$$ and $$F(X)$$ is dense in $$X^*$$. Because $$F$$ is an isometry from $$X$$ to $$F(X)$$, $$X$$ can be identified with $$F(X)$$. Therefore, $$X$$ is isometrically embedded in $$X^*$$.
   
4. The metric space $$\langle X^*, \rho^* \rangle$$ is complete. (N.B. What is convergent here is a sequence of Cauchy sequences.)

   **Proof:** Let $$\{x_n\}_{n \geq 1}$$ be any Cauchy sequence in $$X$$. We can extract a subsequence from it as $$\{x_{n_k}\}_{k \geq 1}$$ such that $$\rho(x_{n_k}, x_{n_{k+1}}) < 2^{-k}$$. This subsequence can be rewritten as $$\{\tilde{x}_k\}_{k \geq 1}$$ with the condition $$\rho(\tilde{x}_k, \tilde{x}_{k+1}) < 2^{-k}$$. Then we select an arbitrary Cauchy sequence of such sequences as $$\{S_m\}_{m \geq 1}$$ with $$S_m = \{\tilde{x}_{k,m}\}_{k \geq 1}$$ satisfying for any $$\varepsilon > 0$$, there exists $$N$$ in $$\mathbb{N}$$ such that when $$m, n > N$$, $$\rho^*(S_m, S_n) = \lim_{k \rightarrow \infty} \rho(\tilde{x}_{k,m}, \tilde{x}_{k,n}) < \varepsilon$$. This suggests that there exists $$K$$ in $$\mathbb{N}$$ such that when $$k > K$$, $$\rho(\tilde{x}_{k,k}, \tilde{x}_{k,n}) < \varepsilon$$. This Cauchy sequence of Cauchy sequences can be illustrated as a 2-dimensional matrix with infinite length as below,

   $$
   \begin{pmatrix}
   \tilde{x}_{1,1} & \tilde{x}_{1,2} & \tilde{x}_{1,3} & \cdots \\
   \tilde{x}_{2,1} & \tilde{x}_{2,2} & \tilde{x}_{2,3} & \cdots \\
   \tilde{x}_{3,1} & \tilde{x}_{3,2} & \tilde{x}_{3,3} & \cdots \\
   \vdots & \vdots & \vdots & \vdots
   \end{pmatrix},
   $$

   from which we extract the diagonal elements to construct a new sequence $$S^* = \{\tilde{x}_{k,k}\}_{k \geq 1}$$. For any $$\varepsilon > 0$$, there exists $$N$$ in $$\mathbb{N}$$ such that when $$m, n > N$$, $$\rho(\tilde{x}_{m,m}, \tilde{x}_{n,n}) < \varepsilon$$. Hence $$S^*$$ is a Cauchy sequence so it belongs to $$X^*$$. The distance between $$S_m$$ and $$S^*$$ is $$\rho^*(S_m, S^*) = \lim_{k \rightarrow \infty} \rho(\tilde{x}_{k,m}, \tilde{x}_{k,k})$$. It is obvious that for any $$\varepsilon > 0$$, when $$m > N$$ and $$k > K$$, $$\rho(\tilde{x}_{k,m}, \tilde{x}_{k,k}) < \varepsilon$$. Therefore, $$\lim_{m \rightarrow \infty} \rho^*(S_m, S^*) = 0$$ and $$\langle X^*, \rho^* \rangle$$ is complete.

   Up to now, the first part of Theorem 9 is proved, i.e. we have found the completion of $$X$$ as $$X^*$$ in which $$X$$ is isometrically embedded as a dense subset.

5. The above isometry $$F$$ from $$X$$ to $$F(X)$$ in $$X^*$$ is uniformly continuous, which is because for any $$x$$ and $$y$$ in $$X$$ such that $$\rho(x, y) < \varepsilon$$, $$\rho^*(F(x), F(y)) = \lim_{n \rightarrow \infty} \rho(x, y) = \rho(x, y) < \varepsilon$$. Then according to Proposition 11 in Section 5 of this Chapter, viewing $$X$$ as a subset of $$Y$$, $$F$$ is a uniformly continuous mapping from $$X$$ into the complete space $$X^*$$. Then there exists a unique continuous extension $$G$$ of $$F$$ from $$X$$ to $$\overline{X}$$ with $$\overline{X}$$ being the closure of $$X$$ with respect to the standard topology induced by the metric. Because $$Y$$ is also complete with respect to this topology, $$\overline{X}$$ is contained within $$Y$$. Also note that, for any $$x$$ in $$\overline{X}$$ but not in $$X$$, there exists a Cauchy sequence $$\{x_n\}_{n \geq 1}$$ in $$X$$ convergent to $$x$$. Then the value $$G(x)$$ only depends on $$x$$, i.e. $$G(x) = \lim_{n \rightarrow \infty} F(x_n)$$.

   Due to Proposition 10 in Section 5, when $$\{x_n\}_{n \geq 1}$$ is a Cauchy sequence in $$X$$, $$\{F(x_n)\}_{n \geq 1}$$ is also a Cauchy sequence because $$F$$ is uniformly continuous. Therefore, $$G(x)$$ belongs to the closure of $$F(X)$$ in $$X^*$$, i.e.  $$\overline{F(X)}$$. Meanwhile, for any $$y$$ in $$\overline{F(X)}$$, there exists a Cauchy sequence $$\{y_n\}_{n \geq 1}$$ in $$F(X)$$ and $$\{x_n\}_{n \geq 1}$$ in $$X$$ such that $$x_n = F^{-1}(y_n)$$. Because $$F$$ is an isometry from $$X$$ to $$F(X)$$, $$F^{-1}$$ is an isometry from $$F(X)$$ to $$X$$ and hence $$F^{-1}$$ is also uniformly continuous. Therefore, $$\{x_n\}_{n \geq 1}$$ is a Cauchy sequence in $$X$$. Then, according to the definition of $$G$$, let $$x$$ in $$\overline{X}$$ and $$x = \lim_{n \rightarrow \infty} x_n$$, we have $$G(x) = y$$. This means that the actual range of $$G$$ is $$\overline{F(X)} = X^*$$.

   On the other hand, viewing $$F(X)$$ as a subset of $$X^*$$, $$F^{-1}$$ is an isometry from $$F(X)$$ to $$X \subset \overline{X}$$, which is also uniformly continuous. Then there exists a unique extension $$H$$ of $$F^{-1}$$ from $$F(X)$$ to $$\overline{F(X)} = X^*$$. So $$H$$ is a map from $$X^*$$ into $$Y$$. With a similar analysis as that for $$G$$, the actual range of $$H$$ is $$\overline{X}$$.

   Then we have $$H \circ G = {\rm id}_{\overline{X}}$$ and $$G \circ H = {\rm id}_{X^*}$$. Therefore, $$G$$ is the inverse of $$H$$ and vice versa. Because $$G$$ is uniformly continuous, $$G$$ is a homeomorphism. Then we need to prove $$G$$ is isometric. We already know that when $$G$$ constrained to $$X$$, $$G\vert_X = F$$ is isometric. Furthermore, for any $$x_1$$ and $$x_2$$ in $$\overline{X}$$, we should prove $$\rho(x_1, x_2) = \rho^*(\{a_n\}_{n \geq 1}, \{b_n\}_{n \geq 1})$$ where $$a_n \rightarrow x_1$$ and $$b_n \rightarrow x_2$$, which is quite obvious: $$\rho^*(\{a_n\}_{n \geq 1}, \{b_n\}_{n \geq 1}) = \lim_{n \rightarrow \infty} \rho(a_n, b_n) = \rho(x_1, x_2)$$. Hence, $$G$$ is an isometry between $$\overline{X}$$ and $$X^*$$.

{{ 2020-09-26-isometric-embedding-of-metric-space | backlink }}
