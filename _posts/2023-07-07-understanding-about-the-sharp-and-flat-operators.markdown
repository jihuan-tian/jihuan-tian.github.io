---
layout: post
title: Understanding about the sharp and flat operators
date: 2023-07-07
categories: [math]
tags: [differential-geometry]
mathjax: true
---

In Lecture 4 $$k $$-forms of the [CMU Discrete Differential Geometry course](https://youtube.com/playlist?list=PL9_jI1bdZmz0hIrNCMQW1YmZysAiIYSSS), it is [mentioned](https://youtu.be/xRf9-hdxB0w?list=PL9_jI1bdZmz0hIrNCMQW1YmZysAiIYSSS&t=938) that a vector and its covector is linked by the sharp ($$\sharp $$) and flat ($$\flat $$) operators. In order to take the inner product of $$u $$ and $$v $$ in the vector space, we treat $$v $$ as the operand and transform $$u $$ into the dual space via the $$\flat $$ operator, then apply it to $$v $$ as $$u^{\flat}(v) $$. In order to take the inner product of the two covectors $$\alpha $$ and $$\beta $$, we transform $$\beta $$ into the vector space via the $$\sharp $$ operator and treat it as the operand, then apply $$\alpha $$ to it as $$\alpha(\beta^{\sharp}) $$. 


The reason for using the operators $$\sharp $$ and $$\flat $$ is because as a convention in differential geometry, a vector (contravariant vector) written in the coordinate component form is assigned with superscripts, such as $$v^i $$, while a covector (covariant vector) is assigned with subscripts, such as $$u_i $$. The $$\sharp $$ operator elevates subscripts into superscripts and vice versa for the $$\flat $$ operator. 


We may also think that because a vector is represented as a row vector and a covector is represented as a column vector, the above $$\sharp $$ and $$\flat $$ operators are simply the transpose operation. However, this is only true when the local coordinate frame for the neighborhood of the interested vector adopts a orthonormal basis, i.e. let the basis be $$\left\{\frac{\vect{\pdiff} }{\vect{\pdiff} x^1}, \cdots, \frac{\vect{\pdiff} }{\vect{\pdiff} x^n}\right\} $$, and we have $$\left\langle \frac{\vect{\pdiff} }{\vect{\pdiff} x^i}, \frac{\vect{\pdiff} }{\vect{\pdiff} x^j} \right\rangle = \delta_{ij} $$. When the basis is not orthonormal, a mass matrix $$M $$ or metric tensor $$g $$ appears: 

$$ M_{ij} = g_{ij} = \left\langle \frac{\vect{\pdiff} }{\vect{\pdiff} x^i}, \frac{\vect{\pdiff} }{\vect{\pdiff} x^j} \right\rangle = J^T J, $$

where 

$$ J = \begin{pmatrix} \frac{\vect{\pdiff} }{\vect{\pdiff} x^1} & \cdots & \frac{\vect{\pdiff} }{\vect{\pdiff} x^n} \end{pmatrix}. $$

When there is a global coordinate frame in which we can explicitly represent the basis $$\left\{\frac{\vect{\pdiff} }{\vect{\pdiff} x^1}, \cdots, \frac{\vect{\pdiff} }{\vect{\pdiff} x^n}\right\} $$ of the local coordinate frame, $$J $$ is just the Jacobian matrix for the map from this local frame to the global frame. Then the metric tensor $$g $$ is also called the Gramian matrix. 


In general, the transformation between a vector and its covector involves the metric tensor $$g $$ and can be written as 



$$ v_{j} = g_{ji} v^i, v^i = g^{ij} v_j, $$
 


where $$g^{ij} $$ is the inverse of the metric tensor. The metric tensor $$g_{ij}$$ and its inverse $$g^{ji}$$ are respectively 2nd rank covariant and contravariant tensors, which are not mixed 2nd rank tensor. Hence they are not equivalent to a linear transformation. That&rsquo;s why if the above transformations are written in matrix form, there are still transpose operations needed to make them correct. For example, 



 1.  The obtained column vector on the left should be transposed to produce a covariant vector:
 
     $$
     
     \begin{pmatrix}
     v_1 \\
      \vdots \\
      v_n
     \end{pmatrix} =
     \begin{pmatrix}
       g_{ij}
     \end{pmatrix}

     \begin{pmatrix}
       v^1 \\
       \vdots \\
       v^n
     \end{pmatrix}
     
     $$

 2.  The input covariant vector should be tranposed first to get the column vector on the right:
 
     $$

     \begin{pmatrix}
     v^1 \\
     \vdots \\
     v^n
     \end{pmatrix} =
     \begin{pmatrix}
       g^{ji}
     \end{pmatrix}

     \begin{pmatrix}
       v_1 \\
       \vdots \\
       v_n
     \end{pmatrix}

     $$


With the above concepts clarified, we will understand the following equations in the lecture slides (N.B. $$M $$ is a symmetric matrix): 

$$ u^{\flat}(v) = (Mu)^T v = u^T M^T v = u^T M v $$

and 

$$ \alpha(\beta^{\sharp}) = \alpha M^{-1} \beta^T. $$
