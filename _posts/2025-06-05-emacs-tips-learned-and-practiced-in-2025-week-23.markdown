---
layout: post
title: Emacs tips learned and practiced in 2025 Week 23
date: 2025-06-05
categories: [computer]
tags: [Emacs]
mathjax: false
---

-   Use `org-fold-hide-sublevels` to hides all sublevel contents including all those headings on a same level with the current one, while `org-fold-hide-subtree` only hide the contents of the current heading.
-   It seems when creating an independent Org Roam node or extract an existing Org headings and its descendants to an Org Roam node, only when there is a time stamp, after upgrading Org Roam database, the node will be visible when I search with `org-roam-node-find`.
    
    Reason: The `ID` property of the node should come first, before the time stamp, in order to be collected into the Org Roam database.

{{ "2025-06-05-emacs-tips-learned-and-practiced-in-2025-week-23" | backlink }}
