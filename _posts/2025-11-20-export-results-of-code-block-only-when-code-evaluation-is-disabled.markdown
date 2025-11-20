---
layout: post
title: Export results of code block only when code evaluation is disabled
date: 2025-11-20
categories: [computer]
tags: [Org-mode]
mathjax: false
---

Previously, I set `org-export-use-babel` to `nil`, so that source code blocks in Org mode would not be evaluated, which can accelerate the export process. The results of the source code blocks were acquired via manual evaluation (press `C-c C-c` on code block). However, this prevents Org mode from parsing the code block header during the export. Therefore, when I use the option `:exports results` to export only the results without source code, it will be ignored.

This is clearly stated in the Org mode manual, Section 16.7 Exporting Code Blocks:

> To stop Org from evaluating code blocks for greater security, set the ‘org-export-use-babel’ variable to ‘nil’, but understand that header arguments will have no effect.

The correct way is to keep `org-export-use-babel` to `t` and use the header argument `:eval never-export` to disable code block evaluation during export.

Then I can export TikZ commutative diagram as a PNG image into a markdown file without including the LaTeX source code and without running `pdflatex` during each export.

```
#+header: :headers '("\\usepackage{tikz}" "\\usepackage{tikz-cd}")
#+header: :imagemagick yes :iminoptions -density 500 :imoutoptions -trim
#+begin_src latex :exports results :eval never-export :results file raw :file figures/2025-11-19-cd-for-discretizing-op-precond.png
\begin{tikzcd}[row sep=7em, column sep=8em]
  H^{-1/2}(\Gamma)
  \arrow[r, "V"]
  \arrow[dr, red, "\mathcal{V}" swap, inner sep=2ex] &
  H^{1/2}(\Gamma)
  \arrow[r, rightharpoonup, shift left=0.5ex, "\hat{D}"]
  \arrow[d, rightharpoondown, shift right=0.5ex, "\mathcal{M}_V" left]
  \arrow[dr, rightharpoonup, red, shift left=0.5ex, "\hat{\mathcal{D}}" pos=0.3] &
  H^{-1/2}(\Gamma)
  \arrow[d, rightharpoondown, shift right=0.5ex, "\mathcal{M}_D" left]
  \arrow[l, rightharpoonup, shift left=0.5ex, "\hat{D}^{-1}"]
  \arrow[dl, rightharpoondown, shift right=0.5ex, "{[\hat{D}^{-1}]}" swap, pos=0.3] \\
  & H^{-1/2}(\Gamma)
  \arrow[u, red, rightharpoondown, shift right=0.5ex, "\mathcal{M}_V^{-1}" swap]
  \arrow[ur, blue, rightharpoondown, shift right=0.5ex, "{[\hat{D}^{-1}]^{-1}}" swap, very near start] &
  H^{1/2}(\Gamma)
  \arrow[u, red, rightharpoondown, shift right=0.5ex, "\mathcal{M}_D^{-1}" right]
  \arrow[ul, rightharpoonup, shift left=0.5ex, "\hat{\mathcal{D}}^{-1}" very near start]
\end{tikzcd}
#+end_src

#+ATTR_ORG: :width 800 :align center
#+ATTR_LATEX: :width 0.5\textwidth
#+RESULTS:
[[file:figures/2025-11-19-cd-for-discretizing-op-precond.png]]
```

{{ "2025-11-20-export-results-of-code-block-only-when-code-evaluation-is-disabled" | backlink }}
