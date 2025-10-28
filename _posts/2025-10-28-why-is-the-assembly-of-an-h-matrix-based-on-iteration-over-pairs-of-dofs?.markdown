---
layout: post
title: "Why is the assembly of an H-matrix based on iteration over pairs of DoFs?"
date: 2025-10-28
categories: [math]
tags: [BEM,HierBEM]
mathjax: true
---

We have been familiar with matrix assembly in FEM, where the integral involving a test function and a trial function is a single integral. This enables us to loop over all cells in the triangulation, compute cell local values, then assemble them into the global matrix according to DoF indices in the cell.

In Galerkin BEM, we need to handle double integrals related to boundary integral operators. Even though the support of a basis function in the test space does not overlap with the support of a basis function in the trial space, because of the long-range kernel of the boundary integral operator, the double integral still has a non-zero value. At first glance, it seems a double loop is needed to compute such an integral, i.e. the outer loop iterates over DoFs in a target cell $$K_x $$ with respect to the variable $$x $$ and the inner loop iterates over DoFs in a source cell $$K_y $$ with respect to the variable $$y $$. However, after obtaining a local matrix for all pairs of DoFs in $$K_x $$ and $$K_y $$, it is difficult to determine into which leaf node in the $$\mathcal{H}$$-matrix and at which local row and column indices of this leaf node we should assemble this local matrix. Furthermore, the ACA procedure for assembling a far field $$\mathcal{H}$$-matrix leaf node involves random selection of rows and columns, which cannot be implemented using the above deterministic pair-cell based double loop.

Therefore, the assembly of an $$\mathcal{H}$$-matrix in HierBEM is based on **iteration over pairs of DoFs**. For a near field leaf node $$b=\tau\times\sigma $$, we use a double loop by iterating over DoFs in the cluster $$\tau $$ (outer loop) and over DoFs in the cluster $$\sigma $$ (inner loop). For a far field leaf node, when a row vector needs evaluation, we use a single loop iterating over DoFs in the cluster $$\sigma $$; when a column vector needs evaluation, we use a single loop iterating over DoFs in the cluster $$\tau $$.

Considering the fact that deal.ii relies on cell iterators to acquire basis function related values and a DoF may be shared by several cells (e.g. when a continuous Lagrange finite element `FE_Q` is adopted), we need to explicitly know to which cells a DoF belongs. In HierBEM, the class `DoFToCellTopology` holds this information.

{{ "2025-10-28-why-is-the-assembly-of-an-h-matrix-based-on-iteration-over-pairs-of-dofs?" | backlink }}
