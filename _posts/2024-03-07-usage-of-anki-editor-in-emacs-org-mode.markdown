---
layout: post
title: Usage of anki-editor in Emacs Org mode
date: 2024-03-07
categories: [computer]
tags: [Emacs,Anki,Org-mode,MathJax,LaTeX]
mathjax: false
---

-   When editing a new Anki note from Emacs Org mode, execute `M-x anki-editor-mode` then `M-x anki-editor-insert-note`.
    
    Because my Anki notes coexist with my formal notes and work journals, I need a way to quickly differentiate them. Adding a `anki` tag to the Anki note heading in Org mode is not perfect, since this tag will also be assigned to Anki cards. Therefore, I choose to always use &ldquo;anki:&rdquo; as the prefix of my Anki note heading, so that it can be easily filtered out by executing the command `helm-org-in-buffer-headings`.
    
    After writing the anki note, execute `M-x anki-editor-push-notes` to transfer the note to Anki.

-   Enable MathJax mode instead of LaTeX mode in Anki card by setting `anki-editor-use-math-jax` to `t`, because the vertical alignment of equations rendered in LaTeX mode is not correct.
-   **Since MathJax is used, display equations as well as math environments should be wrapped between double dollars.** Otherwise, a bare math environment cannot be recognized by MathJax. When a display equation contains an inner math environment, such as `aligned`, **the two pairs of double dollars should be in a same line with `\begin{aligned}` and `\end{aligned}`**. Otherwise, there will be many empty lines inserted between them in the exported content, which disable MathJax rendering of this equation.
-   Because Anki and Org mode now share a common system of tags, tag names should follow the stricter rules required by Org mode. For example, dash &ldquo;-&rdquo; and plus &ldquo;+&rdquo; are not allowed in a tag.
-   Do not specify deck in higher level heading in Org mode. Specify the deck for each note.
-   Sometimes, `anki-editor-push-notes` need to run several times to take effect.
