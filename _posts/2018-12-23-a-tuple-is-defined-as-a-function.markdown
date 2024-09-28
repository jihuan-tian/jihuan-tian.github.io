---
layout: post
title: A tuple is defined as a function
date: 2018-12-23
categories: [math]
tags: [topology]
mathjax: true
---

In James Munkres “Topology”, the concept for a tuple, which can be $$m$$-tuple, $$\omega$$-tuple or $$J$$-tuple, is defined from a *function* point of view as below.

Let $$X$$ be a set.
* Let $$m$$ be a positive integer and $$\{ 1, \cdots, m \}$$ be an index set. An $$m$$-tuple of elements in $$X$$ is a function


   $$
  \vect{x}: \{ 1, \cdots, m \} \rightarrow X.
  $$ 

* Let $$\mathbb{Z}_+$$ be the index set comprised of all positive integers. An $$\omega$$-tuple of elements in $$X$$ is a function


   $$
  \vect{x}: \mathbb{Z}_+ \rightarrow X.
  $$ 

* Let $$J$$ be an index set, whose cardinality is not limited to be finite or infinite, countable or uncountable. A $$J$$-tuple of elements in $$X$$ is a function


   $$
  \vect{x}: J \rightarrow X.
  $$ 

  
For all these types of tuples, if $$\alpha$$ is an index belongs to the index set, the corresponding coordinate component of the tuple is $$\vect{x}(\alpha)$$. It is written as $$x_{\alpha}$$, which is the form we often use.

From the above it can be seen that a tuple of elements, which are literally tangible *data*, are viewed as the rule of assignment for a *function*, which is more abstract. In addition, while we have already been given to the stereotype of a tuple, which is a container holding a list of ordered elements, the function mapping version of a tuple does not require any order relation prescribed for the tuple’s index set. 

Considering these concepts in computer programming, a tuple of values or objects can be either stored in an ordered array as in procedural programming. Or the tuple can be stored within a function as in functional programming. Without loss of generality, this functional perspective can be further applied to matrix and tensor, which eliminates or mingles the boundary between data and operation.

{{ "2018-12-23-a-tuple-is-defined-as-a-function" | backlink }}
