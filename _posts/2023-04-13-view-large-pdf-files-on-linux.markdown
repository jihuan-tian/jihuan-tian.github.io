---
layout: post
title: View large PDF files on Linux
date: 2023-04-13
categories: [computer]
tags: [Linux,PDF]
mathjax: false
---

When we make UML plots for our software project, the page size of the generated PDF file can be extremely huge, e.g. larger than 1 metre, due to the complexity in work flow or data structure. If we examine such a PDF file in Okular, even a tiny mouse scrolling will cause the page to reload, during which black blocks will flash around geometric entities.

Since disabling the &ldquo;Enhance thin lines&rdquo; function (in Settings → Configure Backends → PDF) of the PDF backend in Okular does not help, I have to resort to the classical but more lightweight PDF reader Xpdf. After testing it with my 1507 x 963 mm UML sequence graph, it can be confirmed that Xpdf performs much better and faster than Okular. When rasterizing a PDF page, Xpdf splits it into several blocks and caches a number of them. When we scroll across cached and uncached blocks, even though Xpdf needs a little time to refresh, there is no flashing black blocks anymore.

In addition to this good performance under extreme working conditions, Xpdf provides a bunch of commands which can be bound to user defined keys. For example, the following configuration in my `~/.xpdfrc` enables accelerated scrolling, which is especially suited for viewing large PDF pages.

```text
bind shift-left any scrollLeft(32)
bind shift-right any scrollRight(32)
bind shift-up any scrollUp(32)
bind shift-down any scrollDown(32)
```

<span class="timestamp-wrapper"><span class="timestamp">&lt;2023-04-26 Wed&gt; </span></span> The Postscript and PDF viewer GNU gv performs even better than Xpdf. After loading a large PDF file, there is no refreshing in gv when we scroll the page.

# Lessons learned

Some classical Linux software can be relied upon due to their better speed, extensibility and capability for extreme cases. Good examples are Xpdf, Gnuplot, less, etc.

{{ 2023-04-13-view-large-pdf-files-on-linux | backlink }}
