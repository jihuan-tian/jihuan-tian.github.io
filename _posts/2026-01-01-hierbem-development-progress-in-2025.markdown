---
layout: post
title: 
date: 2026-01-01
categories: [thoughts]
tags: [HierBEM]
mathjax: false
---

-   Implemented operator preconditioning for Laplace boundary integral equations.
-   Extended HierBEM&rsquo;s number system from real to complex values by separating the matrix/vector number type from the kernel number type, and by supporting complex arithmetic on both the PC host and the CUDA device.
-   Applied sequence partition to parallel H-matrix construction and matrix-vector multiplication to achieve improved load balance.
-   Implemented complex-valued iterative solvers, including the preconditioned conjugate gradient (CG) method and the direct generalized minimal residual (GMRES) method, and applied them to complex-valued Laplace problems.
-   Evaluated potentials and conormal traces on target meshes using the representation formula.
-   Refactored the H-matrix assembly pipeline by introducing new classes that abstract BEM function spaces and bilinear forms.
-   Published HierBEM as an open-source project on GitHub under the LGPLv3 license.
-   Created a project website providing an overview of core functionalities and worked examples explaining both the underlying mathematical theory and the source code.
-   Contacted Prof. Wolfgang Bangerth, the lead developer of the deal.II project, and received strong positive feedback; HierBEM is now regarded by deal.II developers as one of the outstanding numerical software projects based on deal.II.
-   Refactored operator preconditioners, laying a solid foundation for the Helmholtz acoustic solvers under development.

-   实现了拉普拉斯边界积分方程的算子预条件方法。
-   通过将矩阵/向量数值类型与核函数数值类型进行区分，并同时支持 PC 主机端与 CUDA 设备端的复数运算，将 HierBEM 的数值体系从实数扩展到了复数。
-   采用序列划分（sequence partition）方法对 H 矩阵的并行构造及矩阵–向量乘法进行了负载均衡优化。
-   实现了复值迭代求解器，包括预条件共轭梯度（CG）方法和直接广义最小残量（GMRES）方法，并将其应用于复值拉普拉斯问题。
-   基于表示公式（representation formula），在目标剖分网格上计算了势函数及其余法向迹（conormal trace）。
-   通过引入用于抽象边界元函数空间和双线性形式的新类，对 H 矩阵装配流程进行了重构。
-   以 LGPLv3 许可证将 HierBEM 作为开源项目发布在 GitHub 上。
-   构建了项目官方网站，系统介绍了核心功能，并通过示例同时讲解了相关的数学理论与源代码实现。
-   联系了 deal.II 项目的负责人 Wolfgang Bangerth 教授，并获得了高度评价；HierBEM 现已被 deal.II 开发者认为是基于 deal.II 的优秀数值软件项目之一。
-   对算子预条件器进行了重构，为正在开发的亥姆霍兹（Helmholtz）声学求解器奠定了坚实基础。

{{ "2026-01-01-hierbem-development-progress-in-2025" | backlink }}
