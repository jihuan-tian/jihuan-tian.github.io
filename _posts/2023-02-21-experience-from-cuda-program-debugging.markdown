---
layout: post
title: Experience from CUDA program debugging
date: 2023-02-21
categories: [thoughts]
tags: [算法开发]
mathjax: false
---

《三体》里汪淼和沙瑞山在宇宙空间尺度上见证了背景辐射的闪烁。关于边界元 CUDA 算法的实现，我在三个月的时间尺度上见证了“山重水复疑无路，柳暗花明又一村”。

如果在算法的软件实现上拥有良好的模块化设计与低耦合度的控制，则应编写足够量的单元测试，以覆盖算法可能运行的不同模式、条件、参数组合。如果软件尚处于理论与概念验证、快速原型构建的初期开发阶段，则编写单元测试可能较为麻烦。此时，就需要直接在算法内部加入足够量的打印输出与对比验证代码。总之，无论是哪种情况，都需要把工作做充分。否则，因为浮沙筑台导致后续的开发根本没法放心、高效地开展。

在代码调试的过程中，等待程序编译的那段时间可以给我带来片刻的闲暇。这一小段时间可作略加休憩，却仍旧不能用来看手机或网页，为的是保证头脑的干净、清醒，维持不被外界与内在打扰、神圣不可侵犯的工作氛围。此时，适宜闭目养神、调整心情、放松身体、向内观想，让思绪化作多股极细的水流，缓缓渗透、经过、浸润由理性编织的密网，从而为我下一次顶住压力、潜入研究的深海、梳理代码中的繁杂细节做好准备。

Sometimes the real cause of some error is hidden beneath the surface, or even outside the realm of our seemingly rigorous and perfect logic. This is because not all the internal or innermost mechanism and system logic are presented to us, either due to the encapsulation of technical details by the product manufacturer, or due to our limited knowledge, experience and crafts. For most of the time, our logical and rational thinking cannot be fully relied upon. Our mission is to enlarge its fidelity and applicability through in-depth thinking and hard working.

{{ "2023-02-21-experience-from-cuda-program-debugging" | backlink }}
