---
layout: post
title: Reverse the colorbar in an Octave figure
date: 2022-05-30
categories: [computer]
tags: [Octave]
mathjax: false
---

Sometimes we want to reverse the direction of the color bar in an Octave figure, which is plotted by `imagesc` or `surf` for example. This can be solved by treating the color bar as an axis object, then setting its `ij` option. This method is obtained from a hint from the documentation:

> Implementation Note: A colorbar is created as an additional axes to the current figure with the &ldquo;tag&rdquo; property set to &ldquo;colorbar&rdquo;. The created axes object has the extra property &ldquo;location&rdquo; which controls the positioning of the colorbar.

An example is given as follows.

<pre class="src src-octave">figure(1<span style="color: #859900;">,</span> <span style="color: #2aa198;">"visible"</span><span style="color: #859900;">,</span> <span style="color: #2aa198;">"off"</span>)<span style="color: #859900;">;</span>
imagesc(toeplitz([1<span style="color: #859900;">:</span>100]<span style="color: #859900;">'</span>))<span style="color: #859900;">;</span>
cb <span style="color: #859900;">=</span> colorbar<span style="color: #859900;">;</span>
axis(cb<span style="color: #859900;">,</span> <span style="color: #2aa198;">"ij"</span>)<span style="color: #859900;">;</span>
img_name <span style="color: #859900;">=</span> <span style="color: #2aa198;">"figures/2022-05-29-octave-reversed-colorbar.png"</span><span style="color: #859900;">;</span>
PrintGCF(img_name)<span style="color: #859900;">;</span>
ans <span style="color: #859900;">=</span> img_name<span style="color: #859900;">;</span>
</pre>

<p align="center"><img src="/figures/2022-05-29-octave-reversed-colorbar.png" alt="" /></p>

{{ 2022-05-30-reverse-the-colorbar-in-an-octave-figure | backlink }}
