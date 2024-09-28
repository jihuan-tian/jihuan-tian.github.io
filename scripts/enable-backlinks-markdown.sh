#!/bin/bash

# Enable backlinks for each markdown file.
for file in *.markdown; do
    base_name=$(basename "$file" .markdown)
    echo -e "\n{{ \"$base_name\" | backlink }}" >> "$file"
done
