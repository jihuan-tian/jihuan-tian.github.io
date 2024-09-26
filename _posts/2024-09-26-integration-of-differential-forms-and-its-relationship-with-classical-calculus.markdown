---
layout: post
title: Integration of differential forms and its relationship with classical calculus
date: 2024-09-26
categories: [math]
tags: [differential-geometry]
mathjax: true
---

- [Introduction](#org52a65b5)
- [Integration of a $$k $$-form over an oriented region in $$\mathbb{R}^k $$](#orgfd454b1)
- [Integration of a $$k $$-form over an oriented parameterized $$k $$-subset in a manifold $$M^n $$](#orgbf32e8c)
  - [Line integral](#orgdb71cf7)
  - [Surface integral](#org063cec0)
  - [Volume integral](#orgdf771ed)


<a id="org52a65b5"></a>

# Introduction

Exterior differential forms are entities to be integrated, not differentiated. For a $$k $$-form, it is to be integrated on a manifold or a subset of a manifold which has $$k $$ dimensions. Therefore, a local coordinate chart with $$k $$ coordinate variables can be assigned to the integration domain.

Force belongs to the cotangent space, while displacement belongs to the tangent space. The application of a force to a displacement is actually a projection of the force to the displacement vector or taking the inner product of these two quantities, and a scalar value, the work done, is returned. This situation fits well with the application of a cotangent vector to a tangent vector where the concept of duality is involved (see [Concept of duality]({% post_url 2024-08-14-concept-of-duality %})).

For electric field, if it is exerted on a point charge, we get the electric force. Therefore, the electric force is just scaling of the electric field. Hence, the electric field should belong to the cotangent space, i.e. it is a 1-form. If we integrate the electric field 1-form along a path, we obtain the potential drop between the starting and ending points of the path.

For magnetic induction or magnetic flux density, it is associated with a 2-form. When it is applied to a 2-vector, it returns the signed area spanned by the 2-vector which is further scaled by the normal component of the magnetic induction. Therefore, the returned scalar value is the magnetic flux through the area. If we integrate the magnetic induction 2-form on a surface, we obtained the total magnetic flux though the surface.


<a id="orgfd454b1"></a>

# Integration of a $$k $$-form over an oriented region in $$\mathbb{R}^k $$

For a coordinate chart $$(U, u) $$ with $$k $$ variables embedded in a manifold $$M^n $$, it is locally homeomorphic to $$\mathbb{R}^k $$. Therefore, the integration on this oriented coordinate chart is just like the integration in a region in $$\mathbb{R}^k $$. So we first examine the integration of a $$k $$-form $$\alpha^k = a(u)du^1\wedge\cdots\wedge du^k $$ over an oriented region in $$\mathbb{R}^k $$.

$$
\begin{equation}
\int_{(U,o)} \alpha^k = \int_{(U,o)} a(u) du^1\wedge\cdots\wedge du^k := o(u) \int_{U} a(u) du^1\cdots du^k.
\end{equation}
$$

$$o(u) $$ determines the orientation of the selected coordinate chart $$(u) $$.


<a id="orgbf32e8c"></a>

# Integration of a $$k $$-form over an oriented parameterized $$k $$-subset in a manifold $$M^n $$

Let $$F $$ be a map from $$U $$ to $$M^n $$, where $$U $$ is assigned a coordinate chart $$(u) $$ with $$k $$ variables. The Jacobian matrix of this map $$F $$ may not have a full rank, hence the range $$F(U) $$ may not have $$k $$ dimensions for all points in it. Therefore, $$F(U) $$ is called a $$k $$-subset of $$M^n $$ and the actual dimension of the geometric entity can be smaller than $$k $$.

The $$k $$-form $$\alpha^k $$ is to be integrated over this $$k $$-subset. The integral should be pulled back to the local coordinate chart $$(u) $$ as below.

$$
\begin{equation}
  \begin{aligned}
    \int_{(U,o; F)} \alpha^k &= \int_{(U,o)} F^{\ast} \alpha^k \\
    &= \int_{(U,o)}
    (F^{\ast}\alpha^k)(\boldsymbol{\partial}u^1,\cdots,\boldsymbol{\partial}u^k)
    du^1\wedge\cdots\wedge du^k \\
    &= o(u) \int_U
    (F^{\ast}\alpha^k)(\boldsymbol{\partial}u^1,\cdots,\boldsymbol{\partial}u^k)
    du^1\cdots du^k \\
    &= o(u) \int_U
    \alpha^k(F_{\ast}(\boldsymbol{\partial}u^1),\cdots,F_{\ast}(\boldsymbol{\partial}u^k))
    du^1\cdots du^k.
  \end{aligned}
\end{equation}
$$

In the above integral, the $$k $$-subset in $$M^n $$ is written as $$(U,o; F) $$, which explicitly specifies the map $$F $$ from $$U $$ to the $$k $$-subset and the orientation function $$o(\cdot) $$. $$F_{\ast}(\boldsymbol{\partial}u^i) $$ is the push forward of the basis vector in the tangent space with the coordinate chart $$(u) $$ to a vector in the manifold $$M^n $$. The matrix representation of $$F_{\ast} $$ is the Jacobian matrix of $$F $$, while the vector representation of $$\boldsymbol{\partial}u^i $$ is $$(0,\cdots,1,\cdots,0)^{\mathrm{T}} $$ with $$1 $$ being the $$i $$-th component. Therefore, $$F_{\ast}(\boldsymbol{\partial}u^i) $$ is just the $$i $$-th column of the Jacobian matrix.


<a id="orgdb71cf7"></a>

## Line integral

In classical calculus, the line integral or path integral of a vector field $$\boldsymbol{A} $$ along a path $$c $$ is

$$
\begin{equation}
  \int_c \boldsymbol{A} \cdot d \boldsymbol{l}.
\end{equation}
$$

In the Cartesian space $$(x) = (x^1,\cdots,x^d) $$, we assume the path $$c $$ has a parametric representation $$x(t) $$, which depends on the unique parameter $$t $$. $$t $$ can be scaled to the range $$[0, 1] $$. Therefore, the infinitesimal directed line segment $$d \boldsymbol{l} $$ is

$$
\begin{equation}
  d \boldsymbol{l} = \frac{dx}{dt} dt,
\end{equation}
$$

where $$t $$ can be considered as time and $$\frac{dx}{dt} $$ is the velocity vector. Therefore, their multiplication produces the infinitesimal directed line segment $$d \boldsymbol{l} $$, which is the displacement within time $$dt $$.

We notice that in the above line integral, the inner product is used, which involves the metric of the space. In classical calculus, only Cartesian space is considered, which has an orthonormal basis, so the inner product possesses a simple form. For example, if $$d=3 $$, we have

$$
\begin{equation}
  \int_{c} \boldsymbol{A}\cdot d \boldsymbol{l} = \int_0^1 \sum_{i=1}^3 A^i \frac{dx^i}{dt} dt.
\end{equation}
$$

However, if an arbitrary coordinate frame is selected for the space which may not be orthonormal, the metric tensor $$g_{ij} $$ will appear, which makes the expression look more complicated:

$$
\begin{equation}
\int_c\boldsymbol{A} \cdot d \boldsymbol{l} =  \int_0^1 \sum_{i=1}^3 \left(\sum_{j=1}^3 g_{ij}A^j\right) \frac{dx^i}{dt} dt.
\end{equation}
$$

Using the Einstein summation notation, this becomes

$$
\begin{equation}
\int_c \boldsymbol{A}\cdot d \boldsymbol{l} = \int_0^1 g_{ij}A^j \frac{dx^i}{dt} dt,
\end{equation}
$$

where $$g_{ij}A^j $$ is just the 1-form associated with the tangent vector $$\boldsymbol{A} $$.

By introducing differential form, the above integral can be simplified, since the metric tensor is inherent in the coordinate transformation property of the differential form. Let $$\alpha^1 = \sum_{i=1}^d a_i dx^i $$ be the 1-form associated with $$\boldsymbol{A} $$. We pull back its integration from the global frame $$(x) $$ to the local chart $$(t) $$:

$$
\begin{equation}
  \begin{aligned}
    \int_c \alpha^1 &= \int_c \sum_{i=1}^d a_i(x) dx^i \\
    &= o(t) \int_0^1 F^{\ast} \left( \sum_{i=1}^d a_i dx^i \right) \\
    &= o(t) \int_0^1 \sum_{i=1}^d a_i(x(t)) F^{\ast}(dx^i) \\
    &= o(t) \int_0^1 \sum_{i=1}^d a_i(x(t)) \frac{dx^i}{dt} dt,
  \end{aligned}
\end{equation}
$$

where $$a_i(x(t)) = g_{ij}(x(t))A^j(x(t)) $$. In the local coordinate chart $$(t) $$, there is only one variable. The orientation of this chart depends on the direction of the unique tangent space basis vector $$dt $$. If we assume $$dt $$ defines the positive orientation, the integration of a 1-form along a path is equivalent to the line integral of a vector field in classical calculus.


<a id="org063cec0"></a>

## Surface integral

In classical calculus, the surface integral of a vector field $$\boldsymbol{B} $$ is only considered in $$\mathbb{R}^3 $$, where the coordinate chart is orthonormal.

$$
\begin{equation}
  \int_{S} \boldsymbol{B}\cdot d \boldsymbol{S}.
\end{equation}
$$

The surface element $$d \boldsymbol{S} $$ has a direction, which is the outward unit normal vector $$\hat{\boldsymbol{n}} $$ of the surface. The classical method projects $$d \boldsymbol{S}$$ to three orthogonal planes, i.e. $$yz $$ , $$zx $$ and $$xy $$ (or we say $$d \boldsymbol{S} $$ is projected along three axes, $$x $$, $$y $$ and $$z $$). If $$\hat{\boldsymbol{n}} = (\cos\alpha,\cos\beta,\cos\gamma) $$, the projected surface elements (with signs) are

$$
\begin{equation}
  \begin{aligned}
    dy\wedge dz &= \cos\alpha dS \\
    dz\wedge dx &= \cos\beta dS \\
    dx\wedge dy &= \cos\gamma dS,
  \end{aligned}
\end{equation}
$$

where $$dS $$ is the non-negative area of the surface element $$d \boldsymbol{S} $$. Obviously, if $$0 \leq \alpha \leq \frac{\pi}{2} $$, the projection of $$d \boldsymbol{S} $$ along the $$x $$ axis is larger than or equal to 0; when $$\frac{\pi}{2} < \alpha \leq \pi $$, the projection is negative. Cases for $$\beta $$ and $$\gamma $$ are similar.

Then the surface integral is the sum of three parts,

$$
\begin{equation}
  \begin{aligned}
    \int_S \boldsymbol{B}\cdot d \boldsymbol{S} &= \int_S B^1 dy\wedge dz + B^2 dz\wedge
    dx + B^3 dx\wedge dy \\
    &= \int_S B^1 \sgn(\cos\alpha) dydz + B^2 \sgn(\cos\beta) dzdx + B^3 \sgn(\cos\gamma)
    dxdy.
  \end{aligned}
\end{equation}
$$

We can see that the signs of those direction cosines are explicitly written out, so that those signed wedge products $$dy\wedge dz $$, $$dz\wedge dx $$ and $$dx\wedge dy $$ are replaced with unsigned surface elements $$dydz $$, $$dzdx $$ and $$dxdy $$. The physical meaning of such surface integral is the flux of the vector field $$\boldsymbol{B} $$ passing through the surface $$\boldsymbol{S} $$.

For the surface integral expressed in differential form, we need a 2-form $$\beta^2 $$. Let $$F $$ be a map from the local coordinate patch $$U $$ to a 2-subset in $$\mathbb{R}^3 $$. This 2-subset is the same as the surface $$S $$. The integral is

$$
\begin{equation}
  \int_{F(U)} \beta^2 = \int_{F(U)} b_1 dx^2\wedge dx^3 + b_2 dx^3\wedge dx^1 + b_3 dx^1\wedge dx^2.
\end{equation}
$$

Pull back to the coordinate chart $$(U, u) $$:

$$
\begin{equation}
  \begin{aligned}
    \int_{F(U)} \beta^2 &= \int_{(U,o)} \left\{ b_1(x(u)) \det \left\{
        \frac{\partial(x^2,x^3)}{\partial(u^1,u^2)} \right\} + b_2(x(u)) \det \left\{
        \frac{\partial(x^3,x^1)}{\partial(u^1,u^2)} \right\} + b_3(x(u)) \det \left\{
        \frac{\partial(x^1,x^2)}{\partial(u^1,u^2)} \right\} \right\}  du^1\wedge du^2 \\
    &= o(u) \int_U \left\{ b_1(x(u)) \det \left\{
        \frac{\partial(x^2,x^3)}{\partial(u^1,u^2)} \right\} + b_2(x(u)) \det \left\{
        \frac{\partial(x^3,x^1)}{\partial(u^1,u^2)} \right\} + b_3(x(u)) \det \left\{
        \frac{\partial(x^1,x^2)}{\partial(u^1,u^2)} \right\} \right\}  du^1du^2.
  \end{aligned}
\end{equation}
$$

Or we can write it as

$$
\begin{equation}
  \begin{aligned}
    \int_{F(U)} \beta^2 &= \int_{(U,o)} F^{\ast}\beta^2 \\
    &= \int_{(U,o)} (F^{\ast}\beta^2)(\boldsymbol{\partial}u^1, \boldsymbol{\partial}u^2)
    du^1\wedge du^2 \\
    &= o(u) \int_U (F^{\ast}\beta^2)(\boldsymbol{\partial}u^1, \boldsymbol{\partial}u^2)
    du^1du^2 \\
    &= o(u) \int_U \beta^2(F_{\ast}\boldsymbol{\partial}u^1, F_{\ast}\boldsymbol{\partial}u^2)
    du^1du^2 \\
    &= o(u) \int_U \beta^2\left(\frac{\partial x}{\partial u^1}, \frac{\partial x}{\partial
      u^2}\right) du^1du^2.
  \end{aligned}
\end{equation}
$$

We already know that in an $$n $$-dimensional manifold, a tangent vector $$\boldsymbol{B} $$ can be identified with a pseudo $$(n-1) $$-form via its interior product with the pseudo volume $$n $$-form. Because the above integral obviously depends on the orientation of the coordinate chart, $$\beta^2 $$ should be a true form. Then the association of a tangent vector and an $$(n-1) $$-form should be modified a little like this: a **pseudo** tangent vector $$\boldsymbol{B} $$ can be identified with a **true** $$(n-1) $$-form via its interior product with the pseudo volume $$n $$-form. Hence, when $$n=3 $$, the pseudo vector $$\boldsymbol{B} $$ corresponds to a true $$2 $$-form $$\beta^2 $$. N.B. The selection of $$\boldsymbol{B} $$ as a pseudo vector is meaningful. For example, in electromagnetics, the magnetic flux density $$\boldsymbol{B} $$ is a pseudo vector not a true vector, because when the orientation of the coordinate charge changes, its direction in the space flips.

Then the 2-form $$\beta^2 $$ is

$$
\begin{equation}
  \beta^2 = i_{\boldsymbol{B}}\mathrm{vol}^3.
\end{equation}
$$

Its integration over $$F(U) $$ is

$$
\begin{equation}
  \begin{aligned}
    \int_{F(U)} \beta^2 &= \int_{F(U)} i_{\boldsymbol{B}}\mathrm{vol}^3 \\
    &= o(u) \int_U i_{\boldsymbol{B}}\mathrm{vol}^3 \left( \frac{\partial x}{\partial u^1}, \frac{\partial x}{\partial
        u^2} \right) du^1du^2 \\
    &= o(u) \int_U \mathrm{vol}^3\left(\vect{B}, \frac{\partial x}{\partial u^1}, \frac{\partial x}{\partial
        u^2}\right) du^1du^2.
  \end{aligned}
\end{equation}
$$

In the above expression, both $$\mathrm{vol}^3 $$ and $$\boldsymbol{B} $$ are pseudo and depend on the orientation of $$\mathbb{R}^3 $$. However, because they appear together, the above integral does not depend on the orientation of $$\mathbb{R}^3 $$ but only depends on the orientation of the local coordinate chart $$(U,u) $$. This means the flux of a vector field through a directed surface only depends on the orientation of the surface but not on the 3D space, which is reasonable.

We can select the surface unit normal vector $$\hat{\boldsymbol{n}} $$ such that the three vectors $$(\hat{\boldsymbol{n}}, \frac{\partial x}{\partial u^{1}}, \frac{\partial x}{\partial u^{2}}) $$ (which have been pushed forward into $$\mathbb{R}^3 $$) have the same orientation as that for $$\mathbb{R}^3 $$. With the normal vector defined, we can decompose the vector field $$\boldsymbol{B} $$ into a normal component $$\boldsymbol{B}_{\mathrm{n}} $$ and a tangential component $$\boldsymbol{B}_{\mathrm{t}} $$, where $$\boldsymbol{B}_{\mathrm{n}} = (\boldsymbol{B}\cdot\hat{\boldsymbol{n}})\hat{\boldsymbol{n}} $$ and $$\boldsymbol{B}_{\mathrm{t}} = \boldsymbol{B} - \boldsymbol{B}_{\mathrm{n}} $$. Then the volume form in the above integral can be further expanded as

$$
\begin{equation}
  o(u) \int_U \mathrm{vol}^3 \left(\boldsymbol{B}, \frac{\partial x}{\partial u^{1}}, \frac{\partial
      x}{\partial u^{2}} \right) du^1du^2 = o(u) \int_{U} \mathrm{vol}^3 \left(
    \vect{B}_{\mathrm{n}} + \vect{B}_{\mathrm{t}}, \frac{\partial
      x}{\partial u^{1}}, \frac{\partial x}{\partial u^{2}} \right) du^1du^2.
\end{equation}
$$

Because $$\boldsymbol{B}_{\mathrm{t}} $$ lies in the plane spanned by the two tangent vectors $$\frac{\partial x}{\partial u^{1}} $$ and $$\frac{\partial x}{\partial u^{2}} $$, $$\boldsymbol{B}_{\mathrm{t}} $$ does not contribute to the volume form. Therefore, the integral becomes

$$
\begin{equation}
  \begin{aligned}
    o(u) \int_{U} \mathrm{vol}^3 \left( \vect{B}_{\mathrm{n}}, \frac{\partial  x}{\partial
      u^{1}}, \frac{\partial x}{\partial u^{2}} \right) du^1du^2 &=  o(u) \int_{U}
  \mathrm{vol}^3 \left( (\vect{B}\cdot\hat{\vect{n}})\hat{\vect{n}}, \frac{\partial
      x}{\partial u^{1}}, \frac{\partial x}{\partial u^{2}} \right) du^1du^2 \\
  &= o(u)
  \int_{U} (\vect{B}\cdot\hat{\vect{n}}) \mathrm{vol}^3 \left( \hat{\vect{n}},
    \frac{\partial x}{\partial u^{1}}, \frac{\partial x}{\partial u^{2}} \right) du^1du^2
  \\
  &= o(u)
  \int_{U} B_{\mathrm{n}} \left( i_{\hat{\vect{n}}}\mathrm{vol}^3 \right) \left(
    \frac{\partial x}{\partial u^{1}}, \frac{\partial x}{\partial u^{2}} \right) du^1du^2,
  \end{aligned}
\end{equation}
$$

where $$B_{\mathrm{n}} $$ is the normal component (in scalar value) of the vector field $$\boldsymbol{B} $$ and $$i_{\hat{\boldsymbol{n}}}\mathrm{vol}^{3} $$ is the area 2-form. Because $$\hat{\boldsymbol{n}} $$ is a pseudo vector and $$\mathrm{vol}^3 $$ is a pseudo form, this area 2-form is a true form. If we let

$$
\begin{equation}
  dS := \left( i_{\hat{\vect{n}}}\mathrm{vol}^3 \right) \left(
    \frac{\partial x}{\partial u^{1}}, \frac{\partial x}{\partial u^{2}} \right) du^1du^2,
\end{equation}
$$

we have

$$
\begin{equation}
\int_{F(U)} \beta^2 = o(u) \int_U B_n dS,
\end{equation}
$$

which is consistent with the flux integral we&rsquo;ve learned in classical calculus.


<a id="orgdf771ed"></a>

## Volume integral

A typical example of the volume integral of a scalar field in $$\mathbb{R}^3 $$ is the integral of charge density $$\rho $$. In classical calculus, this is simply a tri-fold integral

$$
\begin{equation}
 \int_V \rho dxdydz.
\end{equation}
$$

It is obvious that the integral does not depends on the orientation of the coordinate frame.

If differential form is used, we identify the charge density $$\rho $$ with the pseudo volume 3-form $$\rho \mathrm{vol}^3$$. Then its integral over a volume $$F(U) $$ is

$$
\begin{equation}
  \int_{F(U)} \rho \mathrm{vol}^3 = \int_U \rho(u) \mathrm{vol}^3 \left( \frac{\partial
      x}{\partial u^{1}}, \frac{\partial x}{\partial u^{2}}, \frac{\partial x}{\partial
      u^{3}} \right) du^1du^2du^3.
\end{equation}
$$

where $$o(u) $$ in the pseudo volume form cancels with the $$o(u) $$ in the integral and the final result does not depend on the orientation. Or the integral can be written as

$$
\begin{equation}
  \begin{aligned}
    \int_{(F(U), o)} \rho \mathrm{vol}^3 &= \int_{(F(U), o)} \rho(x) o(x) dx^1\wedge x^2\wedge dx^3 \\
    &= \int_{(U,o)} F^{\ast}\left( \rho(x) o(x) dx^1\wedge dx^2\wedge dx^3 \right) \\
    &= \int_{(U,o)} \rho(x(u)) o(u) \Abs{\det \left\{
        \frac{\partial(x^1,x^2,x^3)}{\partial(u^1,u^2,u^3)} \right\}} du^1\wedge
    du^2\wedge du^3\\
    &= \int_U \rho(x(u)) \Abs{\det \left\{
        \frac{\partial(x^1,x^2,x^3)}{\partial(u^1,u^2,u^3)} \right\}} du^1du^2du^3.
  \end{aligned}
\end{equation}
$$
