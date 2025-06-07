---
layout: post
title: When I get lost among the hierarchical headings in Org mode
date: 2025-06-07
categories: [computer]
tags: [Emacs,Org-mode]
mathjax: false
---

When I&rsquo;m editing my notes in Org mode, I may get lost among the hierarchical headings. Then I use the follow measures to localize my position, check its surrounding environment and get an overview.

-   Use `org-previous-visible-heading` (bound to `C-c C-p`) to go to the heading of the current contents.
-   Use `org-fold-hide-sublevels` to hides all sublevel contents including all those headings on a same level with the current one, while `org-fold-hide-subtree` only hide the contents of the current heading. In this way, I can quickly view the list of all same level headings.
-   Show headings to a certain level `n` in the whole buffer: `C-<n> S-tab`
-   Show subheadings to a certain level `n` within the current heading: `C-<n> C-c tab`

{{ "2025-06-07-when-i-get-lost-among-the-hierarchical-headings-in-org-mode" | backlink }}
