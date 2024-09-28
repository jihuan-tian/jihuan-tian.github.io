---
layout: post
title: Insert images to Freeplane using relative links
date: 2023-07-23
categories: [computer]
tags: [Freeplane]
mathjax: false
---

Purpose: insert images into Freeplane mindmaps using relative links to local files, so that the mindmaps are portable to a different folder or computer.

The behavior of inserting images in Freeplane is as below.

-   Right clicking on a node and then adding a local image to it will insert an absolute link, even though in the &ldquo;Environment&rdquo; preferences, hyperlink types has been set to `relative`. This issue can be solved by manually editing the `.mm` file and replacing all absolute links with relative ones.
    <p align="center"><img src="/figures/2023-07-23_17-06-56-relative-hyperlink-type@freeplane.png" alt="Freeplane configuration for hyperlink types" /></p>
    <p align="center">Freeplane configuration for hyperlink types</p>
-   For an image copied from the internet and directly pasted into Freeplane, Freeplane will first make a local copy, then insert it using relative path, which is desired.
-   For an local image pasted directly into Freeplane, Freeplane will link to this image file using relative path, which is desired.
-   The above function provided by Freeplane is enough and the `InsertInlineImage` add-on is not needed anymore.

{{ "2023-07-23-insert-images-to-freeplane-using-relative-links" | backlink }}
