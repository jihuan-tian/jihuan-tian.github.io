---
layout: post
title: Documentation is crucial for numerical software projects
date: 2025-12-14
categories: [thoughts]
tags: [算法开发]
mathjax: false
---

Before I started writing my Galerkin BEM library HierBEM, I surveyed and tried several FEM and BEM open source libraries. Even though some of them were well developed, tested and published, the status of lacking documentation, either intentionally or unintentionally, made me, with limited project experience and mathematical theory about BEM at that time, unable to build my library on top of them. Of course, my programming skill and mathematical foundation were not strong or solid enough to comprehend those open source libraries. Even up to now, there is still a large gap between me and the top level programmers or mathematicians. But anyway, I could not wait for everything to be ready. I had to start to do something. As we all know, practice makes perfect. Doing things by ourselves is the best way to learn. The giant shoulder that I finally stepped upon is the deal.II FEM library. The point that deal.II attracts me is its unparalleled documentation and abundant tutorials. Based on these materials, I started learning deal.II in 2013 and began writing HierBEM in 2020 based on deal.II&rsquo;s mature infrastructure for mesh handling, finite elements, mappings, linear algebra and data output, etc.

This experience makes me realize that to make it possible for a software project keeping a long term sustainable development and maintenance, clear and well organized documentation is crucial. Moreover, for a numerical software project, not only the data structure, work flow and architecture, the mathematical theories behind the algorithms should also be clearly and rigorously summarized, explained and illustrated. Otherwise, I don&rsquo;t see any chance of its survival.

{{ "2025-12-14-documentation-is-crucial-for-numerical-software-projects" | backlink }}
