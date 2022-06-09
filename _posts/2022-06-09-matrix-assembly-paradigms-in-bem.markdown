---
layout: post
title: Matrix assembly paradigms in BEM
date: 2022-06-09
categories: [math]
tags: [BEM]
mathjax: true
---

-   **Assembly on one cell**: for FEM matrices, such as the mass matrix $$M_{ij}=(\varphi_j,\varphi_i) $$, the assembly is carried out by iterating over each cell. This is because the adopted basis functions for both the trial and test finite element spaces have compact support. As a cell-wise local patch or restriction of the global basis function associated with a node, a local basis function has non-zero interaction or overlapping integral only with those in a same cell.
-   **Assembly on a pair of cells**: for full matrices corresponding to boundary integral operators in BEM, such as $$\mathscr{V}, \mathscr{K}, \mathscr{K'}, \mathscr{D} $$, the assembly is performed on each pair of cells in the interested boundary subdomains. Since the integral operators have long range interaction effect, the basis functions in any pair of cells have non-zero Galerkin integral, no matter if they are separated, in contact or overlapped.
-   **Assembly on a pair of DoFs**: for the approximation of boundary integral operators using $$\mathcal{H}$$-matrices, different methods are adopted for building far field and near field matrices. A far field matrix in the rank-k matrix format is built by using ACA. A near field matrix in the full matrix format is built element by element. Since the cluster trees associated with the $$\mathcal{H}$$-matrix are built based on the partition of DoF support points instead of cells, the assembly of a near field full matrix follows the paradigm of &ldquo;on a pair of DoFs&rdquo;.
