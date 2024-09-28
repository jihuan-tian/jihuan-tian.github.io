---
layout: post
title: Theorem 20.3 and metric equivalence in James Munkres Topology
date: 2019-01-08
categories: [math]
tags: [topology]
mathjax: true
---

# Proof of Theorem 20.3

**Theorem 20.3** The topologies on $$\mathbb{R}^n$$ induced by the euclidean metric $$d$$ and the square metric $$\rho$$ are the same as the product topology on $$\mathbb{R}^n$$.

**Proof:** a) Prove the two metrics can mutually limit each other.

Because

$$
\rho(\vect{x}, \vect{y}) = \max_{1 \leq i \leq n} \abs{x_i - y_i} = \left( \max_{1 \leq i \leq n} (x_i - y_i)^2 \right)^{\frac{1}{2}}
$$

and the scalar function $$f(x) = x^{\frac{1}{2}}$$ is increasing when $$x \geq 0$$, then from 

$$
\max_{1 \leq i \leq n} (x_i - y_i)^2 \leq \sum_{i=1}^n (x_i - y_i)^2,
$$

we have

$$
\left( \max_{1 \leq i \leq n} (x_i - y_i)^2 \right)^{\frac{1}{2}} \leq \left( \sum_{i=1}^n (x_i - y_i)^2 \right)^{\frac{1}{2}}.
$$

Hence,

$$
\rho(\vect{x}, \vect{y}) \leq d(\vect{x}, \vect{y}).
$$

Meanwhile,

$$
\left( \sum_{i=1}^n (x_i - y_i)^2 \right)^{\frac{1}{2}} \leq \left( n \max_{1 \leq i \leq n} (x_i - y_i)^2 \right)^{\frac{1}{2}} = \left( n \left( \max_{1 \leq i \leq n} \abs{x_i - y_i} \right)^2 \right)^{\frac{1}{2}}.
$$

Therefore,

$$
d(\vect{x}, \vect{y}) \leq \sqrt{n} \rho(\vect{x}, \vect{y}).
$$

Summarize the above we have

$$
\rho(\vect{x}, \vect{y}) \leq d(\vect{x}, \vect{y}) \leq \sqrt{n} \rho(\vect{x}, \vect{y})
$$

and its equivalent form

$$
\frac{1}{\sqrt{n}} d(\vect{x}, \vect{y}) \leq \rho(\vect{x}, \vect{y}) \leq d(\vect{x}, \vect{y}).
$$

b) Prove the two metrics generate the same topology.

For all $$\vect{x} \in \mathbb{R}^n$$ and $$\varepsilon > 0$$, because $$d(\vect{x}, \vect{y}) \leq \sqrt{n} \rho(\vect{x}, \vect{y})$$, if we let $$\sqrt{n} \rho(\vect{x}, \vect{y}) < \varepsilon$$, we also have $$d(\vect{x}, \vect{y}) < \varepsilon$$. This means the open ball $$B_{\rho}(\vect{x}, \frac{\varepsilon}{\sqrt{n}})$$ in the topology induced by $$\rho$$ is contained in the open ball $$B_d(\vect{x}, \varepsilon)$$ in the topology induced by $$d$$. So the square metric topology is finer than the euclidean metric topology according to Lemma 20.2.

Meanwhile, by letting $$\rho(\vect{x}, \vect{y}) \leq d(\vect{x}, \vect{y}) < \varepsilon$$, we have the open ball $$B_d(\vect{x}, \varepsilon)$$ being contained in the open ball $$B_{\rho}(\vect{x}, \varepsilon)$$, which proves the euclidean metric topology is finer than the square metric topology.

Therefore, the two metrics generate the same topology.

**Comment** It can be seen that when a certain open ball radius is given, the larger the metric being defined, the smaller the open ball in the sense of set inclusion or cardinality.

c) Prove the topology induced by $$\rho$$ is the same as the product topology on $$\mathbb{R}^n$$.

Let $$\vect{B} = \prod_{i=1}^n (a_i, b_i)$$ be a basis element for $$\mathbb{R}^n$$ with the product topology. For all $$\vect{x} \in \vect{B}$$ and $$i \in \{1, \cdots ,n\}$$, there exists an $$\varepsilon_i > 0$$ such that $$x_i \in (x_i - \varepsilon_i, x_i + \varepsilon_i) \subset (a_i, b_i)$$. Let $$\varepsilon = \min_{1 \leq i \leq n} \{ \varepsilon_i\}$$, we have $$x_i \in (x_i - \varepsilon, x_i + \varepsilon) \subset (a_i, b_i)$$. Because $$B_{\rho}(\vect{x}, \varepsilon) = \prod_{i=1}^n (x_i - \varepsilon, x_i + \varepsilon)$$, we have $$\vect{x} \in B_{\rho}(\vect{x}, \varepsilon) \subset \vect{B}$$. Hence, the square metric topology is finer than the product topology on $$\mathbb{R}^n$$.

On the other hand, let $$B_{\rho}(\vect{x}, \varepsilon)$$ be an arbitrary open ball in $$\mathbb{R}^n$$ with the square metric topology, it is itself a basis element for the product topology. Therefore, the product topology is finer than the square metric topology.

Finally, the two metrics generate the same topology as the product topology on $$\mathbb{R}^n$$.

**Comment** It should be noted that although $$B_{\rho}(\vect{x}, \varepsilon) = \prod_{i=1}^n (x_i - \varepsilon, x_i + \varepsilon)$$, we do not have $$B_{\bar{\rho}}(\vect{x}, \varepsilon) = \prod_{i=1}^{\infty} (x_i - \varepsilon, x_i + \varepsilon)$$, where $$\bar{\rho}$$ is the uniform metric on $$\mathbb{R}^{\omega}$$. This point has been mentioned in [this post](https://www.cnblogs.com/peabody/p/10223052.html).

**Remark** This theorem can be generalized as below.

>  If any two metrics $$d_1$$ and $$d_2$$ on a space $$X$$ can be mutually limited, i.e. for all $$x$$ and $$y$$ in $$X$$, there exist positive constants $$C_1$$ and $$C_2$$ such that $$C_1 d_1(x, y) \leq d_2(x, y) \leq C_2 d_1(x, y)$$, then the two metrics induce the same topology on $$X$$. 

Then, these two metrics are considered to be equivalent in a topological sense and such “equivalence” can be understood  like this. We have already known in [this post](https://www.cnblogs.com/peabody/p/10125356.html) that in a topological space, the concept of convergence is defined based on using a collection of nested open sets as rulers for “distance” measurement, when there is still no metric established. The equivalence of two metrics in a topological sense just means that the convergence behaviors in the topological spaces induced from these two metrics are the same.

# Examples of equivalent metrics

In linear algebra, we have already witnessed examples of equivalent metrics, which are induced from corresponding norms for vectors or matrices.

For all $$\vect{x} \in \mathbb{R}^n$$, the following is a list of commonly adopted vector norms:

1. 1-norm: $$\norm{\vect{x}}_1 = \sum_{i = 1}^n \abs{x_i}$$.
2. 2-norm: $$\norm{\vect{x}}_2 = \left( \sum_{i=1}^n \abs{x_i}^2 \right)^{\frac{1}{2}}$$.
3. $$\infty$$-norm: $$\norm{\vect{x}}_{\infty} = \max_{1 \leq i \leq n} \abs{x_i}$$.

It is easy to prove that these norms are equivalent as below, which implies the equivalence of their induced metrics and also the induced topologies on $$\mathbb{R}^n$$.

$$
\begin{align*}
\norm{\vect{x}}_{\infty} \leq & \norm{\vect{x}}_1 \leq n \norm{\vect{x}}_{\infty} \\
\norm{\vect{x}}_{\infty} \leq & \norm{\vect{x}}_2 \leq \sqrt{n} \norm{\vect{x}}_{\infty} \\
\frac{1}{\sqrt{n}} \norm{\vect{x}}_2 \leq & \norm{\vect{x}}_1 \leq n \norm{\vect{x}}_2
\end{align*}.
$$

Based on the definition of vector norms, the corresponding norms for matrices, which are treated as linear operators on vector space, can also be induced. For all $$A \in \mathbb{R}^{n \times n}$$, possible matrix norms are

1. 1-norm: $$\norm{A}_1 = \sup_{\forall \vect{x} \in \mathbb{R}^n, \vect{x} \neq 0} \frac{\norm{A \vect{x}}_1}{\norm{\vect{x}}_1} = \max_{1 \leq j \leq n} \sum_{i=1}^n \abs{a_{ij}}$$, which is the maximum column sum;
2. 2-norm: $$\norm{A}_2 = \sup_{\forall \vect{x} \in \mathbb{R}^n, \vect{x} \neq 0} \frac{\norm{A \vect{x}}_2}{\norm{\vect{x}}_2} = \sqrt{\rho(A^T A)}$$, where $$\rho$$ represents the spectral radius, i.e. the maximum eigenvalue of $$A^TA$$;
3. $$\infty$$-norm: $$\norm{A}_{\infty} = \sup_{\forall \vect{x} \in \mathbb{R}^n, \vect{x} \neq 0} \frac{\norm{A \vect{x}}_{\infty}}{\norm{\vect{x}}_{\infty}} = \max_{1 \leq i \leq n} \sum_{j=1}^n \abs{a_{ij}}$$, which is the maximum row sum.

The equivalence of these matrix norms can be directly derived from the equivalence of vector norms. For example, because $$\norm{A\vect{x}}_1 \leq n \norm{A\vect{x}}_2$$ and $$\norm{\vect{x}}_1 \geq \frac{1}{\sqrt{n}} \norm{\vect{x}}_2$$, we have

$$
\frac{\norm{A\vect{x}}_1}{\norm{\vect{x}}_1} \leq \frac{n \norm{A\vect{x}}_2}{\frac{1}{\sqrt{n}}\norm{\vect{x}}_2} = n\sqrt{n}\frac{\norm{A\vect{x}}_2}{\norm{\vect{x}}_2}.
$$

From $$\norm{A\vect{x}}_1 \geq \frac{1}{\sqrt{n}} \norm{A\vect{x}}_2$$ and $$\norm{\vect{x}}_1 \leq n \norm{\vect{x}}_2$$, we have

$$
\frac{1}{n\sqrt{n}}\frac{\norm{A\vect{x}}_2}{\norm{\vect{x}}_2} \leq \frac{\norm{A\vect{x}}_1}{\norm{\vect{x}}_1}.
$$

By taking supremum operation on both sides of the two inequalities,

$$
\frac{1}{n\sqrt{n}} \norm{A}_2 \leq \norm{A}_1 \leq n\sqrt{n} \norm{A}_2.
$$

Similarly, we also have

$$
\begin{align*}
\frac{1}{n} \norm{A}_{\infty} \leq & \norm{A}_1 \leq n \norm{A}_{\infty} \\
\frac{1}{\sqrt{n}} \norm{A}_{\infty} \leq & \norm{A}_2 \leq \sqrt{n} \norm{A}_{\infty}
\end{align*}.
$$

The equivalence of matrix norms implies the equivalence of their induced metrics and topologies on $$\mathbb{R}^{n \times n}$$.

{{ 2019-01-08-munkres-topology-theo20-3-and-metric-equivalence | backlink }}
