---
layout: post
title: Switch from LibreOffice to Emacs Org mode for work journal
date: 2022-05-16
categories: [computer]
tags: [LibreOffice,Org-mode]
mathjax: false
---

Today, for taking the work journal on algorithm development, I switched from LibreOffice to Emacs Org mode with the following consideration.

1.  As the size of `*.odt` document grows larger and larger, for example, more than 100 pages with images included in my case, LibreOffice&rsquo;s GUI response becomes slow. My normal editing activities are frequently interrupted by automatic or manual saving operations. If still sticking to the LibreOffice solution, I have to split the large document into several smaller ones, for example, split by years as what I&rsquo;ve done for my personal diaries. However, if I resort to Emacs Org mode, which is purely text based, the performance issue will not be a headache. Even though exporting a large Org document to LaTeX format and then compiling it actually need some time, the building process can be made automatic and scheduled at night using script.
2.  Even though the cross referencing functionality in LibreOffice Writer is quite convenient and has pinpoint accuracy, I still cannot add tags to my notes, since LibreOffice Writer is designed as a style-based word processor but not a tool for information management.
3.  Bidirectional document type conversion, content pasting and copying between LibreOffice and others formats, such as Markdown, HTML and LaTeX, are not soundly supported.
4.  There is no solution for efficient LaTeX input and typesetting in LibreOffice. The extension Texmaths is just usable but cannot beat the synergy of Org mode, YASnippet and CDLaTeX.


{{ 2022-05-16-switch-from-libreoffice-to-emacs-org-mode-for-work-journal | backlink }}
