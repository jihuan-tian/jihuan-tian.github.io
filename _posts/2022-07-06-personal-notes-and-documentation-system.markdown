---
layout: post
title: Personal notes and documentation system
date: 2022-07-06
categories: [methodology]
tags: [note-taking,Anki,LaTeX]
mathjax: false
---

Through the years, I have gradually built up and got used to a system for composing and organizing personal notes. The ultimate purpose is to help me solidify and internalize scientific and technical knowledge. The associations between various elements in this system are illustrated in the diagram below.

In addition, I&rsquo;ve adopted these concepts or philosophies during the structure and work flow design of this system as well as settling the criteria for a selection of corresponding tools and media.

-   Orchestrate three key activities: free thinking and derivation, preliminary note organization with sufficient details, formal note compilation with interconnected key points as a knowledge base.
-   Pursue a full understanding and internalization of the knowledge through the four elements with corresponding tools.
    1.  Perform a narrative review process by making Beamer slides.
    2.  Discover and reveal the structure and context buried in the knowledge by drawing mind maps in Freeplane.
    3.  Visualize math by plotting with mathematical accuracy using Asymptote.
    4.  Repeatedly review key points with the help of Anki cards.
-   The editing of note documents should be instant. If a word processor is adopted, as the file grows larger with years, each opening and saving operation becomes slower and interrupts our fluid writing process. Therefore, the working mode, &ldquo;write source code, then compile&rdquo;, is preferred. That&rsquo;s why I choose the Emacs Org mode and LaTeX typesetting system in my solution.
-   Document compilation and generation should be automated. This can be achieved using `Makefile` and periodically scheduled using `crontab`.
-   Disintegrate large documents or archives into small parts to enable fast editing and saving as well as prevent the damage of the whole file.
-   Ensure professional typesetting aesthetic with the tools such as LaTeX and Asymptote.
-   Standardize the typesetting based on a consistent template system.
-   Scratch notes and printed pages should be organized and archived.

<p align="center"><a href="/figures/2022-07-04-notes-and-documentation-system.png"><img src="/figures/2022-07-04-notes-and-documentation-system.png" alt="" /></a></p>
