---
layout: post
title: Orchestration of Zotero and Emacs Org mode for bibliography management
date: 2022-05-24
categories: [computer]
tags: [Emacs,Org-mode,Zotero]
mathjax: false
---

Zotero is a famous bibliography management tool that I&rsquo;ve kept using for a long time. One of its indispensable functions is to automatically grab bibliography information from a web page, download and associate the PDF file of the paper. Previously, I used Zotero with LibreOffice Writer instead of LaTeX or Emacs Org mode, because the interoperability between Zotero and BibTeX lacked at that time. However, the input and visualization of mathematics in LibreOffice Writer is always unsatisfying, which actually influences my writing efficiency and fluency.

Now with the advent of `Better BibTeX` extension for Zotero, the export of the whole bibliography into a BibTeX file can run automatically in the background, whenever there is a change in the library (see Figure 1).

<p align="center"><img src="/figures/2022-05-25_06-07-27-better-bibtex-auto-export.png" alt="Figure 1. Automatic export of Zotero library to BibTeX using Better BibTeX" /></p>
<p align="center">Figure 1. Automatic export of Zotero library to BibTeX using Better BibTeX</p>

On the Emacs side, several packages in cooperation with the Org mode make the direct interaction with BibTeX files and inserting citations into Org files a veritable leisure. They include `org-ref` for inserting citations and cross-references, `helm-bibtex` for managing BibTeX files based on Helm and the bibtex-completion backend (see Figure 2).

<p align="center"><img src="/figures/2022-05-25_06-10-52-insert-citation-with-helm-bibtex-prompt.png" alt="Figure 2. Insert citation with helm-bibtex prompt" /></p>
<p align="center">Figure 2. Insert citation with helm-bibtex prompt</p>

After Zotero and Emacs Org mode are orchestrated, not only a citation key linked with its BibTeX item can be generated with the powerful prompt provided by Helm, a centralized Org note file accompanying the bibliography library can also be created and maintained with full LaTeX support and flexibility of exporting to lots of formats. In addition, when we click on a citation link, the associated PDF file managed by Zotero can be directly opened within our favorite viewer (see Figure 3).

<p align="center"><img src="/figures/2022-05-25_06-05-04-helm-bibtex-open-citation.png" alt="Figure 3. Open citation link from Org mode" /></p>
<p align="center">Figure 3. Open citation link from Org mode</p>

It can be envisioned that once we become familiar with this working mode after some customization and practices, the efficiency and quality of our note taking and paper writing will be exalted to a new level.
