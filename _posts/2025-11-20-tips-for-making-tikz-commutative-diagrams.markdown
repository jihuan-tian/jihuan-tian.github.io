---
layout: post
title: Tips for making tikz commutative diagrams
date: 2025-11-20
categories: [computer]
tags: [LaTeX,Org-mode]
mathjax: false
---

-   Read the tikzcd manual togeter with the TikZ & PGF manual.
-   In a TikZ commutative diagram, both <label text> and <label options> need to be enclosed in curly braces if they contain commas.
-   Specify the position of a label along the arrow path. The numeric values below are distance percentage on the path.
    -   at start: pos=0
    -   very near start: pos=0.125
    -   near start: pos=0.25
    -   midway: pos=0.5
    -   near end: pos=0.75
    -   very near end: pos=0.875
    -   at end: pos=1
-   There should be no empty lines between different matrix entries in the diagram.
-   Determine the correct direction of arrows and their tail directions (if any, such as the harpoon) by rotating the graph so that the starting node is placed on the left and the target node is on the right.
-   By default, a label is placed on the left side of the arrow to which it is attached (relative to the arrow&rsquo;s direction). Inner sep controls the distance between the label and the arrow.
-   Label&rsquo;s position with respect to the arrow: above, below, left, right, swap.
-   Source code block for writing tikz commutative diagrams in Emacs Org mode:
    
    ```
    #+header: :headers '("\\usepackage{tikz}" "\\usepackage{tikz-cd}")
    #+header: :imagemagick yes :iminoptions -density 500 :imoutoptions -trim
    #+begin_src latex :exports results :eval never-export :results file raw :file figure-dir/filename.png
    \begin{tikzcd}
      % ......
    \end{tikzcd}
    #+end_src
    
    #+ATTR_ORG: :width 1000 :align center
    #+ATTR_LATEX: :width 0.5\textwidth
    #+RESULTS:
    [[file:figure-dir/filename.png]]
    ```
    
    If Imagemagick is not specified, the driver for generating PNG images is `dvipng`. According to the tikzcd manual,
    
    > dvi viewers will not display diagrams correctly. It is necessary to convert the dvi file to pdf or ps format—or, even better, use a tool that generates pdf files directly, such as pdflatex.
    
    Therefore, we need to use Imagemagick, which will generate PNG images from PDF files. In the header arguments for Imagemagick, `:iminoptions` specifies the parameters for the input file of Imagemagick, while `:imoutoptions` specifies the parameters for the output file. `-trim` must be used in `:imoutoptions` to crop the image of a4 paper size.
    
    The option `:eval never-export` is used to disable source code evaluation during each export, which can accelerate the export. Meanwhile, the option `:exports results` is still effective, which tell Org to export the results only, without the source code.

{{ "2025-11-20-tips-for-making-tikz-commutative-diagrams" | backlink }}
