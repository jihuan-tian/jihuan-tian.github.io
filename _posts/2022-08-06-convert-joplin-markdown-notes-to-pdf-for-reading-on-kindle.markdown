---
layout: post
title: Convert Joplin Markdown notes to PDF for reading on Kindle
date: 2022-08-06
categories: [computer]
tags: [Joplin,LaTeX,Pandoc,Kindle]
mathjax: false
---

The versatile document converter `pandoc` will be used for this purpose. It transforms the Markdown file to PDF by first converting it to LaTeX then compiling the LaTeX file into PDF.

The command line for calling `pandoc` is like this.

```bash
pandoc -V documentclass=extarticle -V fontsize=12pt -V colorlinks -V urlcolor=NavyBlue --pdf-engine=xelatex -V CJKmainfont="Noto Sans CJK SC" -H export-to-kindle.tex input.markdown -o output.pdf
```

Here I let `pandoc` use the LaTeX package `extsizes` for enabling a larger font in the whole document, such as 12pt, 14pt, 17 pt and 20pt, which is more friendly to my eyes. Hence, the LaTeX document class is set to `extarticle`. Since my Joplin notes captured from web pages usually contain Chinese characters, the LaTeX engine is `xelatex`. The Chinese font is set to Noto Sans CJK SC. The option `-H` is used to specify the LaTeX header file to be included, the content of which is shown below. At the moment, it sets the document background color to solarized yellow and adjusts the page size to be the same as Kindle Paperwhite 3 screen. Meanwhile, the page margin is reduced to 0.5cm and the page number in the footer is disabled.

```latex
\definecolor{solarized-yellow}{RGB}{246,240,222}
\usepackage[pagecolor={solarized-yellow}]{pagecolor}
\usepackage[papersize={3.6in,4.8in},top=0.5cm, bottom=0.5cm, left=0.5cm, right=0.5cm]{geometry}
\pagestyle{empty}
```

{{ "2022-08-06-convert-joplin-markdown-notes-to-pdf-for-reading-on-kindle" | backlink }}
