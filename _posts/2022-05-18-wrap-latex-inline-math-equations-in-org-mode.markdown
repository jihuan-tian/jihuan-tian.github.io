---
layout: post
title: Wrap LaTeX inline math equations in Org mode
date: 2022-05-18
categories: [computer]
tags: [Org mode]
mathjax: false
---

According to the Org mode manual, the dollar sign `$` is treated as math delimiters in the following cases.

-   The enclosed text contains at most two line breaks.
-   The enclosed text is directly attached to the `$` characters with no whitespace between.
-   The closing `$` is followed by whitespace or punctuation.

For example, the dollar signs in `$\alpha$-th` will be escaped as `\$` when it is exported to LaTeX document, just because the closing `$` is not followed by a whitespace or punctuation. N.B. The hyphen character `-` is not treated as punctuation by Org mode.

Therefore, the safest way is to use `\(...\)` for inline math delimiters in Org mode.


{{ 2022-05-18-wrap-latex-inline-math-equations-in-org-mode | backlink }}
