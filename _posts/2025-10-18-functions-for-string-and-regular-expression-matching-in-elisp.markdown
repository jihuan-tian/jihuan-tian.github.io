---
layout: post
title: "Functions for string and regular expression matching in Elisp"
date: 2025-10-18
categories: [computer]
tags: [Emacs]
mathjax: false
---

N.B. When the operation is in a buffer, the function is interactive. When it is in a string, it is non-interactive.

-   String pattern related operations
    -   `search-forward`: search string in a buffer.
    -   `replace-string`: string replacement in a buffer.
    -   `string-replace`: string replacement in a string.
-   Regular expression related operations
    -   `re-search-forward`: search regular expression in a buffer.
    -   `string-match`: regular expression match in a string.
    -   `replace-regexp`: regular expression replacement in a buffer.
    -   `replace-regexp-in-string`: regular expression replacement in a string.
-   Operations after the current match (either string match or regular expression match)
    -   `replace-match`: performs a replacement on the current match in the current buffer or a string, i.e. it acts on the result of a previous search, such as one done with `search-forward`, `re-search-forward`, or `string-match`.
-   Operations after the current match (regular expression match only)
    -   Get the matched text: whole matched string or parenthesized sub-expression in the match
        -   `match-string`
        -   `match-string-no-properties`
    -   Get the position of matched text
        -   `match-beginning`
        -   `match-end`

{{ "2025-10-18-functions-for-string-and-regular-expression-matching-in-elisp" | backlink }}
