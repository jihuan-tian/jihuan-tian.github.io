---
layout: post
title: Print variable values during debugging
date: 2022-05-12
categories: [computer]
tags: [算法开发,Octave,C++]
mathjax: false
---

Printing the value of a simple variable, such as those primitive types in C/C++, is an effective way of debugging numerical algorithms. Since devising a test case for verification of mathematical theories is much more brain taxing and time consuming than the debugging work itself, the benefit of a stepwise running debugger (usually equipped with an IDE) is not manifest anymore. Hence, the seemingly outdated printout of variables is good enough for us to probe algorithm details and localize potential bugs.

In C++, a common trick for printing out the value of a variable in the form `variable_name=variable_value` is to define a macro as below. Here, the operator `#` is adopted to get the literal string of the token passed into the macro. Also beware of the brackets enclosing `variable`. They are requisite to prevent unexpected errors caused by some arbitrary string stored in `variable`.
```c++
#define PRINTOUT(variable) std::cout << #variable << "=" << (variable) << std::endl
```

To realize similar functionality in GNU Octave, I've defined a function `printout_var` as below, which accepts an expression to be evaluated and prints out its string representation and value.
<pre>
<span class="keyword">function</span> <span class="function-name">printout_var</span>(varargin)
  <span class="comment">## printout_var - Print out the value of an expression for debugging
</span>  <span class="comment">## purpose.
</span>
  [reg<span class="builtin">,</span> prop] <span class="builtin">=</span> parseparams(varargin)<span class="builtin">;</span>

  <span class="keyword">if</span> (length(reg) <span class="builtin">&gt;</span> 0)
    fid <span class="builtin">=</span> reg{1}<span class="builtin">;</span>
  <span class="keyword">else</span>
    fid <span class="builtin">=</span> stdout<span class="builtin">;</span>
  <span class="keyword">endif</span>

  <span class="keyword">if</span> (length(prop) <span class="builtin">&gt;</span> 0)
    expression_string <span class="builtin">=</span> prop{1}<span class="builtin">;</span>
    fprintf(fid<span class="builtin">,</span> cstrcat(expression_string<span class="builtin">,</span> <span class="string">" = %s\n"</span>)<span class="builtin">,</span> mat2str(evalin(<span class="string">"caller"</span><span class="builtin">,</span> expression_string)<span class="builtin">,</span> 15))<span class="builtin">;</span>
  <span class="keyword">else</span>
    error(<span class="string">"=== Please provide the expression to be evaluated!"</span>)<span class="builtin">;</span>
  <span class="keyword">endif</span>
<span class="keyword">endfunction</span>
</pre>

In this function, I use `parseparams` to parse the list of arguments with a variable length. The first returned cell array `reg` holds a list of arguments before the first string element in `varargin`, while the second returned cell array `prop` holds the remaining arguments, which begins with the first string argument in `varargin`. The first non-string argument as an integer is treated as the file descriptor `fid` for the printout. The first string argument is the mandatory expression `expression_string`.

To evaluate the expression, I use the built-in function `evalin`. Being different from the commonly used `eval`, it can specify the context, either `caller` or `base`, in which the expression is executed. Here, I set the context to `caller`. This is mandatory because the evaluation takes place in the local scope of my function `printout_var`, while `printout_var` needs to print those variables defined outside its own environment. It is obvious that when `printout_var` is called from an interactive session of Octave, which is our usual working scenario for debugging, the `caller` context is actually the same as the `base` context. In addition, `mat2str` is used to convert the numerical result into string representation. It is suitable for both scalar and matrix values, which is better than `num2str`.

{{ "2022-05-12-print-variable-values-during-debugging" | backlink }}
