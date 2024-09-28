---
layout: post
title: Continuity of arithmetic operations
date: 2019-02-03
categories: [math]
tags: [topology]
mathjax: true
---

Arithmetic operations taught in elementary schools are continuous in the high level topological point of view. This signifies that there is literally no clear boundary between simple and complex, low and high concepts. Instead, they both play indispensable roles in mathematics with their conflation forming a unified logical system. In this post, a proof will be provided for the continuity of arithmetic operations, which are depicted in Exercise 12 of Section 21 and Theorem 21.5 in James Munkres "Topology".

# Arithmetic operations on real numbers are continuous

**Exercise 21.12** Prove continuity of the algebraic operations on $$\mathbb{R}$$, as follows: Use the metric $$d(a, b) = \abs{a - b}$$ on $$\mathbb{R}$$ and the metric on $$\mathbb{R}^2$$ given by the equation

 $$
\rho((x,y),(x_0,y_0))=\max\{\abs{x-x_0},\abs{y-y_0}\}.
$$ 

**Analysis** The proof relies on Theorem 21.1. For a function $$f: X \rightarrow Y$$, by fixing an arbitrary $$x_0$$ in $$X$$ and confining the variation of the independent variable $$x$$ around this $$x_0$$ to a specified range $$\delta$$, the variation $$\varepsilon$$ of the function value $$f(x)$$ around $$f(x_0)$$ can be arbitrarily small. By the way, it can be extended that an upper bound is set to $$\varepsilon$$ and Theorem 21.1 still holds.

**Proof** (a) Show the addition operation is continuous.

Fix $$(x_0, y_0)$$ in $$\mathbb{R}\times\mathbb{R} $$ and select $$(x,y)$$ in a range which ensures that for all $$\varepsilon>0$$, $$d(x+y, x_0+y_0) < \varepsilon$$. Then

 $$
\begin{aligned}
d(x+y,x_0+y_0)&=\abs{(x+y)-(x_0+y_0)}\\
&\leq \abs{x-x_0}+\abs{y-y_0}\\
&\leq 2\rho((x,y),(x_0,y_0))
\end{aligned}.
$$ 

By enforcing $$2\rho((x,y),(x_0,y_0)) < \varepsilon$$, we have $$\rho((x,y),(x_0,y_0)) < \frac{\varepsilon}{2}$$. Therefore, let $$\delta=\frac{\varepsilon}{2}$$, when $$\rho((x,y),(x_0,y_0)) < \delta$$, $$d(x+y,x_0+y_0) < \varepsilon$$. Hence, the addition operation is continuous.

(b) Show the multiplication operation is continuous.

Fix $$(x_0,y_0)$$ in $$\mathbb{R}\times\mathbb{R}$$, we have

 $$
\begin{aligned}
d(xy, x_0y_0) &= \abs{xy - x_0y_0} = \abs{xy - x_0y + x_0y - x_0y_0}\\
&=\abs{(x-x_0)y + x_0(y-y_0)} \\
&=\abs{(x-x_0)y - (x-x_0)y_0 + (x-x_0)y_0 + x_0(y-y_0)} \\
&=\abs{(x-x_0)(y-y_0) + (x-x_0)y_0 + x_0(y-y_0)}\\
&\leq \abs{x-x_0}\cdot\abs{y-y_0} + \abs{x-x_0}\cdot\abs{y_0} + \abs{x_0}\cdot\abs{y-y_0} \\
&\leq \rho((x,y),(x_0,y_0))^2 + \rho((x,y),(x_0,y_0))\abs{x_0} + \rho((x,y),(x_0,y_0))\abs{y_0}
\end{aligned}.
$$ 

Then, for all $$0 < \varepsilon \leq 1$$, enforce the above inequality less than $$\varepsilon$$:

 $$
\begin{aligned}
d(xy, x_0y_0) &\leq \rho((x,y),(x_0,y_0))^2 + \rho((x,y),(x_0,y_0))\abs{x_0} + \rho((x,y),(x_0,y_0))\abs{y_0} \\
& < \varepsilon \leq 1
\end{aligned}.
$$ 

Because $$\rho((x,y),(x_0,y_0))^2<1$$, $$\rho((x,y),(x_0,y_0))^2 \leq \rho((x,y),(x_0,y_0))$$. Then we adopt a stronger enforcement by letting

 $$
\begin{aligned}
d(xy, x_0y_0) &\leq \rho((x,y),(x_0,y_0))^2 + \rho((x,y),(x_0,y_0))\abs{x_0} + \rho((x,y),(x_0,y_0))\abs{y_0} \\
& \leq \rho((x,y),(x_0,y_0)) + \rho((x,y),(x_0,y_0))\abs{x_0} + \rho((x,y),(x_0,y_0))\abs{y_0} \\
& = \rho((x,y),(x_0,y_0)) (1 + \abs{x_0} + \abs{y_0}) \\
& < \varepsilon
\end{aligned}.
$$ 

This leads to

 $$
\rho((x,y),(x_0,y_0)) < \frac{\varepsilon}{1 + \abs{x_0} + \abs{y_0}}.
$$ 

Because $$(x_0,y_0)$$ is given as a fixed point, the right hand side of the above inequality is a definite value. By letting $$\delta = \frac{\varepsilon}{1 + \abs{x_0} + \abs{y_0}}$$, when $$\rho((x,y),(x_0,y_0))<\delta$$, we have $$d(xy,x_0y_0)<\varepsilon$$ and the multiplication operation is continuous.

(c) Show the subtraction operation is continuous.

First, let $$f: \mathbb{R} \rightarrow \mathbb{R}$$ with $$f(x)=-x$$ be the negation operation. For any open interval $$(a,b)$$ in $$\mathbb{R}$$, $$f^{-1}((a,b)) = (-b,-a)$$, which is also open. Hence $$f$$ is continuous.

Then we prove Exercise 10 in Section 18, which will be used afterwards.

**Exercise 18.10** Let $$f: A \rightarrow B$$ and $$g: C \rightarrow D$$ be continuous functions. Let us define a map $$f \times g: A \times C \rightarrow B \times D$$ by the equation

 $$
(f \times g)(a \times c) = f(a) \times g(c).
$$ 

Show that $$f \times g$$ is continuous.

Let $$U$$ be open in $$B$$ and $$V$$ be open in $$D$$. Then $$U \times V$$ is a topological basis of the produce space $$B \times D$$. According to the definition of the product map $$f \times g$$,

 $$
(f \times g)^{-1}(U \times V) = f^{-1}(U) \times g^{-1}(V).
$$ 

Because both $$f$$ and $$g$$ are continuous, $$f^{-1}(U)$$ is open in $$A$$ and $$g^{-1}(V)$$ is open in $$C$$. Therefore, $$f^{-1}(U) \times g^{-1}(V)$$ is a basis of $$A \times C$$. Hence $$f \times g$$ is continuous.

With Exercise 18.10 proved, $$F: \mathbb{R} \times \mathbb{R} \rightarrow \mathbb{R} \times \mathbb{R}$$ with $$F(x,y)=(x,-y)$$ is a continuous function, because its first coordinate map is the continuous identity map and its second coordinate map is the continuous negation operation. Then, the subtraction operation can be treated as a composition of $$F$$ and the continuous addition operation. According to Theorem 18.2 (c), the subtraction operation is continuous.

(d) Show the reciprocal operation $$f: \mathbb{R} - \{0\} \rightarrow \mathbb{R}$$ with $$f(x) = \frac{1}{x}$$ is continuous.

N.B. The domain of $$f$$ is a subspace of $$\mathbb{R}$$ having the subspace topology.

Let $$(a,b)$$ be an arbitrary open interval in $$\mathbb{R}$$ and we consider the following five cases.

* For $$a>0$$ and $$b>0$$: $$f^{-1}((a,b)) = (\frac{1}{b}, \frac{1}{a})$$.
* For $$a<0$$ and $$b<0$$: $$f^{-1}((a,b)) = (\frac{1}{b}, \frac{1}{a})$$.
* For $$a=0$$ and $$b>0$$: $$f^{-1}((a,b)) = (\frac{1}{b}, \infty)$$.
* For $$a<0$$ and $$b=0$$: $$f^{-1}((a,b)) = (-\infty, \frac{1}{a})$$.
* For $$a<0​$$ and $$b>0​$$: $$f^{-1}((a,b)) = f^{-1}((a,0) \cup (0,b))​$$. Because the inverse map preserves set operations,

   $$
  f^{-1}((a,0) \cup (0,b)) = f^{-1}((a,0)) \cup f^{-1}((0,b)) = (-\infty, \frac{1}{a}) \cup (\frac{1}{b}, \infty).
  $$ 


$$f^{-1}((a,b))$$ is open in $$\mathbb{R} - \{0\}$$ under the above five cases, so $$f$$ is continuous.

(e) Show the quotient operation is continuous.

Define a function $$G: \mathbb{R} \times \mathbb{R} - \{0\} \rightarrow \mathbb{R} \times \mathbb{R} - \{0\}$$ with $$G(x,y) = (x,\frac{1}{y})$$. $$G$$ is a continuous function according to Exercise 18.10 and part (d). Furthermore, the multiplication operation with its domain restricted to $$\mathbb{R} - \{0\}$$ is also continuous due to Theorem 18.2 (d). Then the quotient operation as a composition of $$G$$ and the domain-restricted multiplication operation is continuous.

# Arithmetic operations on the space of continuous functions are continuous

**Theorem 21.5** If $$X$$ is a topological space, and if $$f, g: X \rightarrow \mathbb{R}$$ are continuous functions, then $$f+g$$, $$f-g$$ and $$f \cdot g$$ are continuous. If $$g(x) \neq 0$$ for all $$x$$, then $$f/g$$ is continuous.

**Comment**

1. This theorem is a high level version of Exercise 21.12. It states the arithmetic operations on real-valued functions instead of on real numbers.
2. As already introduced in [this post](https://www.cnblogs.com/peabody/p/10145036.html), arithmetic operations on continuous functions is one of the ways to construct new continuous functions.

**Proof** Take the addition operation $$f+g$$ as example. It is defined as $$(f+g)(x)=f(x)+g(x)$$, which can be considered as a composition of two functions $$h_1: \mathbb{R} \rightarrow f(\mathbb{R}) \times g(\mathbb{R})$$ with $$h_1(x)=(f(x),g(x))$$ and $$h_2: f(\mathbb{R}) \times g(\mathbb{R}) \rightarrow \mathbb{R}$$ with $$h_2(x,y)=x+y$$. For each coordinate map of $$h_1$$, it is the continuous identity map. According to Theorem 18.4 (Maps into products), $$h_1$$ is continuous. $$h_2$$ is the addition operation with a restricted domain, which is also continuous. Therefore $$f+g=h_2 \circ h_1$$ is continuous.

Similarly, we can prove $$f-g$$, $$f \cdot g$$ and $$f/g$$ with $$g(x) \neq 0$$ for all $$x$$ are continuous.

{{ "2019-02-03-continuity-of-arithmetic-operations" | backlink }}
