---
layout: post
title: Problems of preview-latex
date: 2023-10-21
categories: [computer]
tags: [LaTeX,preview-latex,AUCTeX,lstlistings]
mathjax: false
---

`preview-latex` is a handy function provided by AUCTeX for directly rendering LaTeX equations and inserted figures in a Emacs buffer under the `latex-mode`. `lstlistings` is LaTeX package for highlighting source code. According to my experience, when `lstlistings` package is used, `preview-latex` have the following problems, some of which can be overcome actually.

-   When `\lstlistofalgorithms` appears at the end of a LaTeX document, `preview-latex` will get stuck and consume 100% CPU.
    
    Solution: remove `sections` from the variable `preview-default-option-list` in `preview-latex`, which will stop processing `\lstlistofalgorithms`.
-   Preview of math symbols in a `lstlistings` algorithm is a mess.
-   Math symbols in an environment introduced by `ntheorem`, such as `Theorem`, `Definition`, `Remark`, etc., will become bold face in the preview.
-   A `\mbox` command appearing in the `postbreak` property of `lstlistings` configuration will make `preview-latex` fail.
    
    As shown below, the `\mbox` command should be replaced with `\hbox`. The difference between `\mbox` and `\hbox` is [here](https://tex.stackexchange.com/a/118169).
    
    ```latex
    \makeatletter
    \@ifclassloaded{beamer}{
      \newsavebox\redarrow
      \sbox\redarrow{\raisebox{0ex}[0ex][0ex]{\ensuremath{\color{red}\hookrightarrow\space}}}
      \lstset{postbreak=\usebox\redarrow}
    }{\lstset{postbreak=\mbox{\textcolor{red}{$\hookrightarrow$}\space}}}
    \makeatother
    ```

{{ 2023-10-21-problems-of-preview-latex | backlink }}
