---
layout: post
title: Progress update of HierBEM
date: 2026-07-04
categories: [thoughts]
tags: [hierbem]
mathjax: true
---

Finished the implementation of precomputing and storing cell values for the regular cell neighboring type, i.e. the two cells $$K_x $$ and $$K_y $$ for the test and trial spaces are well separated. These cell values include Jacobian determinants, normal vectors, quadrature point coordinates and surface curls. The purpose of their precomputation is to improve the performance of H-matrix assembly, especially when the H-matrix has less data sparsity due to locally dense mesh or small admissibility constant.

The said precomputation mechanism is applied to three code branches in HierBEM: full matrix assembly, H-matrix assembly without the producer-consumer model or task buffers, H-matrix assembly with the producer-consumer model and task buffers. The first two branches are only used for verification and performance baseline, while the third one is for production.

Meanwhile, some low level functions for computing the said cell values are reorganized and made platform shared, namely

-   `transform_quad_point_from_unit_to_permuted_real_cell`
-   `surface_jacobian_det_and_normal_vector`
-   `surface_jacobian_det_normal_vector_and_covariant`
-   `surface_curl`

They can now be called on both the CPU host and GPU device, which reduces redundant code and possibility of making errors.

Classes for BEM values `BEMValues` and scratch data `PairCellWiseScratchData`, which are frequently used by numerical quadrature, are refactored for the three code branches for H-matrix assembly. Redundant memory allocation for data tables in BEM values and scratch data are also removed. For example,

-   `PairCellWiseScratchDataBase` is used by the low level function `transform_quad_point_from_unit_to_permuted_real_cell` and the H-matrix builder with the producer-consumer model and task buffers but only for near field matrix blocks.
-   `PairCellWiseScratchDataForFullMatrix` is used by the full matrix builder.
-   `PairCellWiseScratchDataForHMatrix` is used by the H-matrix builder without the producer-consumer model or task buffers.
-   `PairCellWiseScratchDataForHMatrixFarField` is used by the H-matrix builder with the producer-consumer model and task buffers only for far field matrix blocks.

Now for the baseline test case for solving a Laplace Dirichlet problem constructed on a two sphere model with 4041 nodes and 4033 quadrangles, the total wall time is reduced to 75 seconds. Compared to the old version without any precomputation, 10 times of performance improvement has been achieved.

-   Before precomputation of mapping support points: 771 seconds.
-   After precomputation of mapping support points: 364 seconds.
-   After precomputation of cell values: 75 seconds.

{{ "2026-07-04-progress-update-of-hierbem" | backlink }}
