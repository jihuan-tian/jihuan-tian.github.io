#!/bin/bash

# Enable backlinks for each HTML file.
for file in *.html; do
    base_name=$(basename "$file" .html)
    echo -e "\n<p>{{ $base_name | backlink }}</p>" >> "$file"
done
