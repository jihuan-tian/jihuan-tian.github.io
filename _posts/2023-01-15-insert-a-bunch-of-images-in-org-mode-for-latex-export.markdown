---
layout: post
title: Insert a bunch of images in Org mode for LaTeX export
date: 2023-01-15
categories: [computer]
tags: [LaTeX,Org-mode]
mathjax: false
---

For writing test reports, we often need to insert a bunch of small figures into the document, which has a gallery effect. In Emacs Org mode with LaTeX as the export backend, the collection of images should be placed in a `center` environment. In addition, the `:center` LaTeX property should be added in the `ATTR_LATEX` directive.

The source code in Org mode:

```text
#+BEGIN_CENTER
#+ATTR_HTML: :width 500px
#+ATTR_LATEX: :width 0.35\textwidth :center
[[file:./figures/image1.png]]
#+ATTR_HTML: :width 500px
#+ATTR_LATEX: :width 0.35\textwidth :center
[[file:./figures/image2.png]]
#+ATTR_HTML: :width 500px
#+ATTR_LATEX: :width 0.35\textwidth :center
[[file:./figures/image3.png]]
#+END_CENTER
```

The exported LaTeX code:

```latex
\begin{center}
  \includegraphics[width=0.35\textwidth]{../figures/image1.png}
  \includegraphics[width=0.35\textwidth]{../figures/image2.png}
  \includegraphics[width=0.35\textwidth]{../figures/image3.png}
\end{center}
```

{{ 2023-01-15-insert-a-bunch-of-images-in-org-mode-for-latex-export | backlink }}
