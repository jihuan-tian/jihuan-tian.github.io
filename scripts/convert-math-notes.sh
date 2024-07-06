#!/bin/bash

pandoc -f latex -t markdown-citations --citeproc --csl=chicago-author-date-16th-edition.csl --bibliography=../../../../../academic/Papers/zotero/zotero-library.bib -o "${1%tex}markdown" "$1"
gawk -i inplace -f ../scripts/org-to-latex-to-md.awk "${1%tex}markdown"
