---
layout: post
title: Write LaTeX display equations with no numbering in Org mode
date: 2023-07-28
categories: [computer]
tags: [LaTeX,Org-mode,Emacs]
mathjax: false
---

The variable `org-format-latex-options`&rsquo;s `:matchers` field is used to configure how Org mode detects a LaTeX fragment. However, according to the comment of the function `org-inside-LaTeX-fragment-p`,

> Even though the matchers for math are configurable, this function assumes that \\\begin, \\\\(, \\\\[, and $$ are always used. Only the single dollar delimiters are skipped when they have been removed by customization.

Therefore, Org mode always tries to recognize the outer-most `\begin{environment-name}...\end{environment-name}` as a display equation and everything between them as the environment contents. This behavior makes Org mode unable to correctly render the following equation.

Example 1: the first environment name `pmatrix` happens to be the same as the second one, then the LaTeX fragment image can be generated, but still `\[ ... \]` are left behind.

```latex
\[
  \begin{pmatrix}a & b \\ c & d \end{pmatrix} + 
  \begin{pmatrix}a & b \\ c & d \end{pmatrix}
\]
```

![img](/figures/2023-07-28_14-51-59-display-equation-in-org-mode-example1.png)

Example 2: the first environment name `pmatrix` does match the second one `bmatrix`, Org mode then reports an error and does not produce any image.

```latex
\[
  \begin{pmatrix}a & b \\ c & d \end{pmatrix} + 
  \begin{bmatrix}a & b \\ c & d \end{bmatrix}
\]
```

Open the temporary LaTeX file, we can see there nothing after `\begin{pmatrix}`.

```latex
{\color{fg}
\begin{pmatrix}%
}

\end{document}
```

Solution to the above problem: always use `\begin{equation*} ... \end{equation*}` to write display equations with no numbering in Org mode.

```latex
\begin{equation*}
  \begin{pmatrix}a & b \\ c & d \end{pmatrix} + 
  \begin{bmatrix}a & b \\ c & d \end{bmatrix}
\end{equation*}
```

{{ 2023-07-28-write-latex-display-equations-with-no-numbering-in-org-mode | backlink }}
