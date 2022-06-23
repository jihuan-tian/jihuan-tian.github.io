#!/bin/bash

file_base_name=`basename "$1" .odt`

# Convert odt to docx
libreoffice --convert-to docx "$1"
# Convert docx to html using Python package mammoth
mammoth --output-format=html --output-dir=./ --style-map=../scripts/markdown-to-html-style-map "$file_base_name.docx"
# Convert html to markdown using pandoc
pandoc -f html -t markdown -o "$file_base_name.markdown" "$file_base_name.html"
