---
layout: post
title: Ship of Theseus and scientific software development
date: 2022-05-02
categories: [methodology]
tags: [算法开发,Octave,C++]
mathjax: false
---

The “[Ship of Theseus](https://en.wikipedia.org/wiki/Ship_of_Theseus)” is a philosophical question about the identity of a ship during its renovation. If the parts of the ship were incrementally replaced piece by piece, would it still preserve its original identity as the ship of Theseus after the whole maintenance was finished? If it finally became a different new ship, when did it start to possess the identity of the new ship?

Leave aside the answer to this question, the spirit of “piece-by-piece” replacement can be borrowed as an effective software engineering methodology which is especially suitable for developing scientific libraries and tools.

Due to the innate theoretical difficulty and intricacies of mathematical algorithms, it is usually unrealistic to mix their derivation and verification with software design at the very beginning, since these two tasks have quite distinct properties and both of them need a huge amount of time resource. The former relies on mathematical thinking and usually requires a trial-and-error process. The latter focuses on the design of data structure and organization of functional modules, which involves a logical thinking oriented to categorization and demarcation.

For a scientific software, to be mathematically correct is its first priority. Hence, we need an easy-to-use language (not necessarily having high performance) to bash out lines of source code as an implementation of the algorithms. After several rounds of quick debug and validation, we can get the first wave of confidence about our theory. My recommendation about the scripting language is GNU Octave, which is the best choice for dealing with verification work in the early stage of scientific software development. Although the abstraction and integration power of Octave’s grammar as well as the amount of functional packages is very limited compared to Python equipped with `Numpy`, `SciPy` and `Matplotlib`, it is literally much simpler to use and is absolutely enough for expressing our mathematical ideas.

When a mockup program written in Octave is implemented and verified, it is necessary to carry out a performance profiling to detect any possible bottleneck in the code. Luckily, Octave provides the command `profile` for this purpose. After localizing those bottleneck functions, we can translate their original Octave scripts to C++ functions and compile them into a shared library. Then, write a wrapper function in C++ for each function in the shared library by following the conventions adopted by Octave to interface with C++ language. The wrapper function should be compiled it into a `*.oct` file using the command line tool `mkoctfile`, which can be  finally used to replace the corresponding `*.m` file in Octave.

Following the above procedures, the performance of our mathematical algorithms can be improved significantly, for example, more than 100 times faster. If incorporating this methodology as a golden rule into our development activity, after several rounds of iteration, the C++ shared library will grow larger and larger, and more and more Octave scripts in the initial mockup program will be replaced by those compiled `*.oct` files. When most or all of the key working functions are replaced, we come to a stage that only a few configuration and/or caller scripts in Octave are left, which merely play a lesser role as testers for the C++ algorithms. But still, Octave’s good enough data processing and visualization capabilities are very helpful and convenient for us to verify the C++ code. Meanwhile, a caller function in C++ can also be written, which finally consummates the maintenance task for the Ship of Theseus.
