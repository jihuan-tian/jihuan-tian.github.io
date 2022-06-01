---
layout: post
title: Realize argument parsing similar to the "plot" function in Octave
date: 2022-06-01
categories: [computer]
tags: [Octave]
mathjax: false
---

In GNU Octave, the frequently used `plot` function has several overloaded versions as below.

    -- : plot (Y)
    -- : plot (X, Y)
    -- : plot (X, Y, FMT)
    -- : plot (..., PROPERTY, VALUE, ...)
    -- : plot (X1, Y1, ..., XN, YN)
    -- : plot (HAX, ...)
    -- : H = plot (...)

The arguments passed to `plot` have two main features as below, which make its function calling very flexible.

1.  The argument list has a variable length.
2.  After numeric parameters, such as `HAX`, `X` and `Y`, there are multiple of `PROPERTY-VALUE` pairs.

In my previous projects, when I wrote a function requiring different combinations of arguments, I would use `varargin` as its formal parameter, which wraps the list of input arguments in a cell array. Depending on the length of `varargin`, different parsing schemes were implemented.

<pre class="src src-octave"><span style="color: #859900;">function</span> <span style="color: #268bd2;">foo</span>(varargin)
  <span style="color: #859900;">switch</span> (length(varargin))
    <span style="color: #859900;">case</span> 1<span style="color: #859900;">:</span>
    <span style="color: #859900;">case</span> 2<span style="color: #859900;">:</span>
    <span style="color: #859900;">case</span> 3<span style="color: #859900;">:</span>
  <span style="color: #859900;">endswitch</span>
<span style="color: #859900;">endfunction</span>
</pre>

As an alternative, I might also explicitly list all the possible parameters in the function&rsquo;s signature. Then, inside the function body, I used the `exist` function to check their availability and assigned default values to the missing variables.

<pre class="src src-octave"><span style="color: #859900;">function</span> <span style="color: #268bd2;">foo</span>(image_handle<span style="color: #859900;">,</span> file_name<span style="color: #859900;">,</span> line_color)
  <span style="color: #859900;">if</span> (<span style="color: #859900;">!</span>exist(<span style="color: #2aa198;">"image_handle"</span><span style="color: #859900;">,</span> <span style="color: #2aa198;">"var"</span>))
    <span style="color: #93a1a1; font-style: italic;">## Assign the default value to @p image_handle with the current figure</span>
    <span style="color: #93a1a1; font-style: italic;">## handle.</span>
    image_handle <span style="color: #859900;">=</span> gcf<span style="color: #859900;">;</span>
  <span style="color: #859900;">endif</span>

  <span style="color: #859900;">if</span> (<span style="color: #859900;">!</span>exist(<span style="color: #2aa198;">"file_name"</span><span style="color: #859900;">,</span> <span style="color: #2aa198;">"var"</span>))
    <span style="color: #93a1a1; font-style: italic;">## Default image file for saving.</span>
    file_name <span style="color: #859900;">=</span> <span style="color: #2aa198;">"output.png"</span><span style="color: #859900;">;</span>
  <span style="color: #859900;">endif</span>

  <span style="color: #859900;">if</span> (<span style="color: #859900;">!</span>exist(<span style="color: #2aa198;">"line_color"</span><span style="color: #859900;">,</span> <span style="color: #2aa198;">"var"</span>))
    line_color <span style="color: #859900;">=</span> <span style="color: #2aa198;">"r"</span><span style="color: #859900;">;</span>
  <span style="color: #859900;">endif</span>
<span style="color: #859900;">endfunction</span>
</pre>

It is obvious that the first method above requires lots of code to write, if there are many cases to be handled. For the second method, all the parameters are locked to their positions in the function&rsquo;s signature, which is not flexible. Therefore, a new programming pattern is needed in order to implement a function similar to the internal function `plot`.

To solve this problem, Octave&rsquo;s `parseparams` and `inputParser` class can be used. As shown in the following example code for plotting support points in a finite element cell, I pass `varargin` firstly to `parseparams`. It will separate the parameter list into two groups `reg` and `prop`. `reg` stores all the leading numeric arguments, while `prop` stores the remaining ones, the first of which should be a string. In my case, there is only one optional leading numeric parameter, which is the figure handle. Therefore, by checking the length of `reg`, figure handle can be obtained from the argument or set to the current figure via `gcf`.

Next, an `inputParser` object `p` is created for parsing and extracting both required parameters and parameter-value pairs. Note that each call of the parameter adding member function, like `p.addRequired` and `p.addParameter`, a function handle is passed as the last argument, which is responsible for user input validation. This is consistent with the spirit of defensive programming and makes our code more robust. Moreover, a default value should be provided for defining a parameter-value pair.

Finally, to run the parser `p`, call its member function `parse` on the unwrapped cell array `prop{:}`. The calling convention of `plot_support_points` now becomes consistent with `plot`.

<pre class="src src-octave"><span style="color: #859900;">function</span> <span style="color: #268bd2;">plot_support_points</span>(varargin)
  <span style="color: #93a1a1; font-style: italic;">## The function @p parseparams is used for splitting the argument</span>
  <span style="color: #93a1a1; font-style: italic;">## list into figure handle part and the remaining part.</span>
  [reg<span style="color: #859900;">,</span> prop] <span style="color: #859900;">=</span> parseparams(varargin)<span style="color: #859900;">;</span>

  <span style="color: #859900;">if</span> (length(reg) <span style="color: #859900;">&gt;</span> 0)
    h <span style="color: #859900;">=</span> reg(1)<span style="color: #859900;">;</span>
  <span style="color: #859900;">else</span>
    h <span style="color: #859900;">=</span> gcf<span style="color: #859900;">;</span>
  <span style="color: #859900;">endif</span>

  p <span style="color: #859900;">=</span> inputParser()<span style="color: #859900;">;</span>
  p.FunctionName <span style="color: #859900;">=</span> <span style="color: #2aa198;">"plot_support_points"</span><span style="color: #859900;">;</span>
  p.addRequired(<span style="color: #2aa198;">"data_file"</span><span style="color: #859900;">,</span> @ischar)<span style="color: #859900;">;</span>
  val_float <span style="color: #859900;">=</span> @(x) isscalar(x) <span style="color: #859900;">&amp;&amp;</span> isfloat(x)<span style="color: #859900;">;</span>
  p.addParameter(<span style="color: #2aa198;">"offx"</span><span style="color: #859900;">,</span> 0.02<span style="color: #859900;">,</span> val_float)<span style="color: #859900;">;</span>
  p.addParameter(<span style="color: #2aa198;">"offy"</span><span style="color: #859900;">,</span> 0.02<span style="color: #859900;">,</span> val_float)<span style="color: #859900;">;</span>
  p.addParameter(<span style="color: #2aa198;">"marker"</span><span style="color: #859900;">,</span> <span style="color: #2aa198;">"o"</span><span style="color: #859900;">,</span> @ischar)<span style="color: #859900;">;</span>
  p.addParameter(<span style="color: #2aa198;">"markersize"</span><span style="color: #859900;">,</span> 12<span style="color: #859900;">,</span> val_float)<span style="color: #859900;">;</span>
  p.addParameter(<span style="color: #2aa198;">"markerfacecolor"</span><span style="color: #859900;">,</span> <span style="color: #2aa198;">"r"</span><span style="color: #859900;">,</span> @ischar)<span style="color: #859900;">;</span>
  p.addParameter(<span style="color: #2aa198;">"markeredgecolor"</span><span style="color: #859900;">,</span> <span style="color: #2aa198;">"r"</span><span style="color: #859900;">,</span> @ischar)<span style="color: #859900;">;</span>
  p.addParameter(<span style="color: #2aa198;">"labelsize"</span><span style="color: #859900;">,</span> 18<span style="color: #859900;">,</span> val_float)<span style="color: #859900;">;</span>

  p.parse(prop{<span style="color: #859900;">:</span>})<span style="color: #859900;">;</span>
<span style="color: #859900;">endfunction</span>
</pre>
