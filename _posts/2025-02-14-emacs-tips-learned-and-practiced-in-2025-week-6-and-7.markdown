---
layout: post
title: Emacs tips learned and practiced in 2025 Week 6 and 7
date: 2025-02-14
categories: [computer]
tags: [emacs,Org-mode]
mathjax: false
---

-   Use `ibuffer-mode` to manage many opened buffers in batch, since they can be marked using regular expressions.
-   Started to migrate large work journals from Org subtrees to independent org-roam notes using the function `org-roam-extract-subtree`. This will reduce the file size and heading levels in the Org file. After a work journal has been migrated, a link to it should be created as a heading below a related category in the original Org file. This is to realize the concept of **note index** in the Zettelkasten method.
    
    Meanwhile, a timestamp should be attached to this link, so that this note will appear in the Org agenda. Because independent org-roam notes have their file names prefixed with timestamps, we can also review notes taken each day or each week in the file explorer.
-   Installed the `highlight-indent-guides` package to visualize the hierarchy of Org items. Sometimes the items are deeply nested, which is difficult to navigate.
-   Since I do not directly export my Org notes to HTML, I&rsquo;ve replaced all `#+ATTR_HTML` attributes that are used for specifying the width of inline images with `#+ATTR_ORG`. This new keyword only controls the display size of the inline images.

{{ "2025-02-14-emacs-tips-learned-and-practiced-in-2025-week-6-and-7" | backlink }}
