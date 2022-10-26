---
layout: post
title: Navigation in Org mode for instant editing
date: 2022-10-26
categories: [computer]
tags: [Emacs,Org-mode]
mathjax: false
---

To realize the concept of instant editing, it is beneficial for us to get familiar with navigation operations in Org mode. In this post, I&rsquo;ll summarize those that I use most during my note-taking and task management activities.

-   `S-TAB`: Global visibility cycling
-   Display headings to a certain level
    -   `C-<n> C-c TAB`: place a cursor at a heading and press this hotkey to show its subheadings to level `<n>`.
    -   `C-<n> S-TAB`: show all headings in the current buffer to level `<n>`.
        
        For my personal journal, I put the writing year, date and article title in the first, second and third level headings respectively. Then I often use this function to browse the list of journal titles by showing the headings to level 3, while the contents are still folded.
       <p align="center"><img src="/figures/2022-10-26_15-59-40-journal-titles-in-org-mode.png" alt="" /></p>
-   Quickly jump back and forth in Org mode
    -   `org-mark-ring-push` (`C-c %`): push the current cursor location into the ring buffer.
    -   `org-mark-ring-goto` (`C-c *`): go to the previous cursor location in the ring buffer.
-   `org-goto` (`C-c C-j`): quickly jump to a heading in the current file via interactive search.
-   `C-c C-x b`: Open a subtree in an indirect buffer.
    
    This is very useful for focusing to a specific subtree for reading and editing.
    <p align="center"><img src="/figures/2022-10-26_16-01-21-subtree-in-indirect-buffer.png" alt="" /></p>
