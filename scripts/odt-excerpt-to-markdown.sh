#!/bin/bash

file_base_name=`basename "$1" .odt`

# Convert odt to docx
libreoffice --convert-to docx "$1"
# Convert docx to html using Python package mammoth
mammoth "$file_base_name.docx" "$file_base_name.html" --output-format=html --style-map=../scripts/markdown-to-html-style-map
# Convert html to markdown using pandoc
pandoc -f html -t markdown -o "$file_base_name.markdown" "$file_base_name.html"
# Correct page numbers in the markdown file.
gawk -i inplace -f ../scripts/correct-page-no-from-kindle.awk "$file_base_name.markdown"
