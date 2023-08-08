#!/bin/bash

pandoc -f latex -t gfm --bibliography ../../../../../academic/Papers/zotero/zotero-library.bib -o "$1".markdown "$1".tex
gawk -i inplace -f ../scripts/org-to-latex-to-md.awk "$1".markdown
