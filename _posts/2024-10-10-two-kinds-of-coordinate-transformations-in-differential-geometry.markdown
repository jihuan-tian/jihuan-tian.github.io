---
layout: post
title: Two kinds of coordinate transformations in differential geometry
date: 2024-10-10
categories: [math]
tags: [differential-geometry]
mathjax: true
---

In differential geometry, the coordinate transformation between different local charts is merged into an entity itself, such as tangent vector, tensor and differential form, instead of being explicitly written out. This makes the expression of physical laws concise and help reveal their invariant properties.

Typically, there are two kinds of coordinate transformations:

1.  For a physical entity, such as tangent vector, it has different coordinates or numerical representations in different coordinate charts. Then there is the rule of transformation between these representations.
    
    For example, we have two coordinate charts $$(U,x) $$ and $$(V,y) $$. The transition map from $$U $$ to $$V $$ is $$\Phi_{VU}: (U,x) \rightarrow (V,y) $$, which is actually
    
    $$
    \begin{equation}
      \begin{aligned}
        y^1 &= y^1(x^1,\cdots,x^{m}) \\
        &\vdots \\
        y^n &= y^n(x^1,\cdots,x^m)
      \end{aligned}.
    \end{equation}
    $$
    
    N.B. The number of coordinate components in $$v_x $$ and $$v_y $$ may not be the same. This is natural: $$p $$ in $$\mathbb{R}^3 $$ has three coordinate components, while if $$p $$ is on a surface with a local 2D coordinate chart, it has two components.
    
    Let $$p $$ be a point (as a physical entity) in the overlap of $$U $$ and $$V $$. Let $$v $$ be a tangent vector rooted at $$p $$. The numerical representations of $$v $$ in these two coordinate charts are
    
    $$
    \begin{equation}
    v_x = v_x^i \boldsymbol{\partial} x^i, \; v_y = v_y^i \boldsymbol{\partial} y^i.
    \end{equation}
    $$
    
    Then the transformation from $$v_x $$ to $$v_y $$ is the Jacobian map of $$\Phi_{VU} $$:
    
    $$
    \begin{equation}
    v_y^i = \frac{\partial y^i}{\partial x^j} v_x^j.
    \end{equation}
    $$

2.  For two physical entities, there is also a transformation between them, such as a basis vector in a coordinate chart expanded using the basis of another coordinate chart.
    
    Assume we have two coordinate charts $$(U,x) $$ and $$(V,y) $$, both containing a point $$p $$ in $$M^n $$. For the tangent space $$M_p^n $$ at $$p $$, the bases of these two coordinate charts are $$\left\{ \boldsymbol{\partial}x^i \right\}_{i=1}^n $$ and $$\left\{ \boldsymbol{\partial}y^j \right\}_{j=1}^{n'} $$, where $$n' $$ may not be equal to $$n $$. In their respective chart, $$\boldsymbol{\partial}x^i $$ or $$\boldsymbol{\partial}y^j $$ is numerically the same as $$\boldsymbol{e}_i $$ or $$\boldsymbol{e}_j $$. The numerical representation of $$\boldsymbol{\partial}x^i $$ in $$(V,y) $$ is
    
    $$
    \begin{equation}
      \boldsymbol{\partial}x^i = \sum_j \frac{\partial y^j}{\partial x^i} \boldsymbol{\partial}y^j.
    \end{equation}
    $$
    
    Another example is the transformation of a metric tensor $$g $$, which is a covariant tensor of 2nd rank. Under the above two coordinate charts, it is expressed as
    
    $$
    \begin{equation}
      g_{rs}^U = \left\langle \boldsymbol{\partial}x_U^r, \boldsymbol{\partial}x_U^s \right\rangle
    \end{equation}
    $$
    
    and
    
    $$
    \begin{equation}
      g_{ij}^V = \left\langle \boldsymbol{\partial}y_V^i, \boldsymbol{\partial}y_V^j \right\rangle.
    \end{equation}
    $$
    
    The metric tensor comprises basis vectors in the tangent space, so the relationship between $$g $$ in different coordinate charts follows the same transformation rule for a basis vector in the tangent space as above. Therefore, we have
    
    $$
    \begin{equation}
      \begin{aligned}
        \boldsymbol{\partial}y_V^i &= \sum_r \frac{\partial x_U^r}{\partial y_V^i}
        \boldsymbol{\partial}x_U^r \\
        \boldsymbol{\partial}y_V^j &= \sum_s \frac{\partial x_U^s}{\partial y_V^j}
        \boldsymbol{\partial}x_U^s
      \end{aligned}.
    \end{equation}
    $$
    
    Then
    
    $$
    \begin{equation}
      g_{ij}^V = \left\langle \sum_r \frac{\partial x_U^r}{\partial y_V^i} \boldsymbol{\partial}x_U^r,
        \sum_s \frac{\partial x_U^s}{\partial y_V^j} \boldsymbol{\partial}x_U^s \right\rangle =
      \sum_r\sum_s \frac{\partial x_U^r}{\partial y_V^i} \frac{\partial x_U^s}{\partial y_V^j}
      \left\langle \boldsymbol{\partial}x_U^r, \boldsymbol{\partial}x_U^s \right\rangle = \sum_r\sum_s
      \frac{\partial x_U^r}{\partial y_V^i} \frac{\partial x_U^s}{\partial y_V^j} g_{rs}^U.
    \end{equation}
    $$
    
    Its matrix form is
    
    $$
    \begin{equation}
      G^V = \left[ \frac{\partial x_U}{\partial y_V} \right]^{\mathrm{T}} G^U \left[ \frac{\partial
          x_U}{\partial y_V} \right] = J_{UV}^{\mathrm{T}} G^U J_{UV}.
    \end{equation}
    $$
    
    N.B. We should not directly substitute the numerical representation of a tangent space basis vector in its respective coordinate chart into the expression of the metric tensor. For example, in the expression of $$g_{rs}^U $$, the numerical representations for $$\boldsymbol{\partial}x_U^r $$ and $$\boldsymbol{\partial}x_U^s $$ in their own coordinate chart $$(U,x) $$ are $$\boldsymbol{e}_r $$ and $$\boldsymbol{e}_s $$. If we use $$\boldsymbol{e}_r $$ and $$\boldsymbol{e}_s $$ to compute $$g_{rs}^U $$, we&rsquo;ll find out its matrix form is simply an identity matrix, which is obviously wrong if the coordinate chart is not orthonormal.
    
    The correct way to compute $$g_{rs}^U $$ is to start from the metric tensor for the Cartesian space $$\mathbb{R}^n $$, which is already known as $$g_{pq} = \delta_{pq} $$, where $$\delta_{pq} $$ is the Kronecker delta. Because the coordinate transformation between the chart $$(U,x) $$ and the Cartesian space is known, we can compute $$g_{rs}^U $$ from $$g_{pq} $$ using the above transformation formula. With $$g_{rs}^U $$ and the coordinate transformation between $$(U,x) $$ and $$(V,y) $$ at hand, we can further compute $$g_{ij}^V $$ from $$g_{rs}^U $$.
    
    The above explanation indicates that the computation of a metric tensor for an arbitrary coordinate chart cannot **bootstrap**. It must start from the metric tensor for a Cartesian space $$\mathbb{R}^n $$ and a coordinate transformation rule between this chart and $$\mathbb{R}^n $$.
