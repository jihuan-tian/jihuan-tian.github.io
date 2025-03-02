---
layout: post
title: Rules for tagging notes
date: 2025-03-02
categories: [thoughts]
tags: [note-taking]
mathjax: false
---

-   The purpose of defining and applying tags is to locate a collection of related notes whenever we want to retrieve and use them. Since we already have organized personal knowledge into folders and categories (hierarchical headings in Org mode) by instinct, tags just provide us another dimension which describes more detailed information or features about the notes. So if a tag is too general, why don&rsquo;t we directly use categories? If a tag is too specific, why don&rsquo;t we directly use string or regular expression search?
    
    We should not define overlapping or hierarchical tags and tags should not be too specific. Otherwise, each note will have its own tags and searching these tags is equivalent to searching the contents. Remember that we are using tags to filter a collection of notes, not a unique one.
    
    For short, a tag can be considered as an atomic feature which are shared by a number of notes.

-   Define tags from different dimensions or perspectives
    -   Activities during project development and mathematical exploration: `optimization`, `test_report`, `debug`, `design`, `failure`, `trial`, `idea`, `toolbox`, etc.
    -   Task status: `milestone`, `published`, etc.
    -   Content keywords
    -   Physical properties of the notes: `scan`, `mindmap`, `sketch`, etc.
-   Write short introduction for tags
    
    Because the above dimensions or perspective are based on our understanding and intention about how to manage our knowledge, exploration process, project execution, there must be some design ideas and principles here. So it is necessary to describe the purpose and function of the tags.
-   Use a single language for all tags and make them lower case.

Some ideas above are borrowed from [How to use tags by Karl Voit](https://karl-voit.at/2022/01/29/How-to-Use-Tags/).

{{ "2025-03-02-rules-for-tagging-notes" | backlink }}
