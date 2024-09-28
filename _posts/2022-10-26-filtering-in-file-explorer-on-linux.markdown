---
layout: post
title: Filtering in file explorer on Linux
date: 2022-10-26
categories: [computer]
tags: [Emacs,KDE,Dired-mode]
mathjax: false
---

When we write a LaTeX document, there will be a bunch of intermediate or temporary files generated in the same folder as the TeX file, such as `*.aux`, `*.synctex.gz`, `*.out`, `*.toc`, `*.thm`, `*.bbl`, `*.blg`. This brings mess to our browsing experience in the file explorer. To focus on those files which need our editing and reading, we can use the filter function provided by Dolphin, the default KDE file explorer on Linux, to show only TeX files or PDF files. In addition, by clicking on the small lock icon at the right of the filter bar, the current filter can be kept effective when we change to another folder.

<p align="center"><img src="/figures/2022-10-26_14-27-54-dolphin-latex-files.png" alt="Many intermediate files are displayed in Dolphin by default" /></p>
<p align="center">Many intermediate files are displayed in Dolphin by default</p>

<p align="center"><img src="/figures/2022-10-26_14-45-14-dolphin-latex-files-filtered.png" alt="TeX files are filtered to be shown in Dolphin" /></p>
<p align="center">TeX files are filtered to be shown in Dolphin</p>

However, the capability of the Dolphin&rsquo;s file name filter is still limited. It only checks if a file name contains the input string and it does not support pattern matching. To to apply a more complex file name filter, we can resort to the Emacs `Dired` mode. The procedures are summarized below.

1.  Press `C-x d` to enter the `Dired` mode.
2.  Press `% m` to mark desired files via regular expression matching, such as `tex$`, `pdf$`, etc.
3.  Press `% m` again to mark more files, if needed.
4.  Press `t` to invert the selection, i.e. all unmarked files are selected.
5.  Press `k` to kill all lines corresponding to the marked files. N.B. This operation does not delete the files, but just filter them out from the `Dired` buffer.
6.  Press `g` again to restore the display of all files in the folder.

<p align="center"><img src="/figures/2022-10-26_21-20-41-file-filter-in-emacs-dired.png" alt="Only TeX and PDF files are displayed in the Dired mode in Emacs" /></p>
<p align="center">Only TeX and PDF files are displayed in the Dired mode in Emacs</p>

{{ "2022-10-26-filtering-in-file-explorer-on-linux" | backlink }}
