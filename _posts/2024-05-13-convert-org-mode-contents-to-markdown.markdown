---
layout: post
title: Convert Org mode contents to markdown
date: 2024-05-13
categories: [computer]
tags: [Awk,Markdown,Org-mode]
mathjax: false
---

According to my experience, a feasible work flow for exporting Org mode contents including math equations to markdown (either used for GitHub Pages or Gitlab) needs three steps.

1.  Export the Org mode contents to a LaTeX file.
2.  Convert the LaTeX file to GFM markdown format using `pandoc`, which also handles the citation of bibliography.
    
    ```text
    pandoc -f latex -t gfm --bibliography <bibtex-file> -o <markdown-file> <latex-file>
    ```
    
    <span class="timestamp-wrapper"><span class="timestamp">&lt;2024-06-15 Sat&gt; </span></span> N.B. `gfm` should not be used in Debian Bookworm, otherwise math symbols will not be exported as LaTeX but as UTF-8 characters. Use `markdown` instead.
3.  Make LaTeX equations in the markdown file suitable for the `kramdown` grammar adopted by Jekyll used in GitHub Pages and `KaTeX` provided by Gitlab.
    
    With `kramdown`, both inline and display math equations should be wrapped between double-dollars, except that the double-dollars for display equations should be on independent lines and separated from surrounding paragraphs with additional empty lines.
    
    With `KaTeX` in Gitlab, for best compatibility of equation rendering, inline equations should be placed within ``$`...`$`` instead of `$...$`, while display equations should be wrapped in the source code block
    
    ```text
    ```math
    ```
    ```
    
    instead of double-dollars.
    
    I use Awk script to help me with the above processing.
    
    -   For GitHub Pages
        
        ```awk
        {
            # Replace inline equation wrappers.
            gsub(/\\\(/, "$$");
            gsub(/\\\)/, "$$");
        
            # Replace the beginning display equation wrapper.
            if (match($0, /^(\s*)\\\[\s*$/, match_spaces) != 0) {
                # If there is only \[ in the line.
        
                # Get the prefixed spaces to ensure correct indentation.
                prefix_spaces = match_spaces[1];
                $0 = gensub(/^(\s*)\\\[\s*$/, "\n" prefix_spaces "$$", 1);
            }
            else if (match($0, /^(\s*)\\\[\s*/, match_spaces) != 0) {
                # If \[ is in a same line with the equation text.
        
                # Get the prefixed spaces to ensure correct indentation.
                prefix_spaces = match_spaces[1];
                $0 = gensub(/^(\s*)\\\[\s*/, "\n\\1$$\n" prefix_spaces, 1);
            }
        
            # Replace the ending display equation wrapper.
            if (match($0, /^\s*\\\]\s*$/) != 0) {
                # If there is only \] in the line.
                $0 = gensub(/^\s*\\\]\s*$/, prefix_spaces "$$\n", 1);
                prefix_spaces = "";
            }
            else if (match($0, /\\\]\s*/) != 0) {
                # If \] is in a same line with the equation text, add prefix spaces first to
                # this line. Then move \] to the new line.
                $0 = gensub(/^(.*\\\]\s*)$/, prefix_spaces "\\1", 1);
                $0 = gensub(/\\\]\s*/, "\n" prefix_spaces "$$\n", 1);
                prefix_spaces = "";
            }
        
            # Process bibliography item.
            $0 = gensub(/^(<div id="ref-.+)>$/, "\\1 markdown=\"1\">", 1);
        
            print prefix_spaces $0;
        }
        ```
    -   For Gitlab
        
        ```awk
        {
            # Replace inline equation wrappers.
            gsub(/\\\(/, "$`");
            gsub(/\\\)/, "`$");
        
            # Replace the beginning display equation wrapper.
            if (match($0, /^(\s*)\\\[\s*$/, match_spaces) != 0) {
                # If there is only \[ in the line.
        
                # Get the prefixed spaces to ensure correct indentation.
                prefix_spaces = match_spaces[1];
                $0 = gensub(/^(\s*)\\\[\s*$/, "\n" prefix_spaces "```math", 1);
            }
            else if (match($0, /^(\s*)\\\[\s*/, match_spaces) != 0) {
                # If \[ is in a same line with the equation text.
        
                # Get the prefixed spaces to ensure correct indentation.
                prefix_spaces = match_spaces[1];
                $0 = gensub(/^(\s*)\\\[\s*/, "\n\\1```math\n" prefix_spaces, 1);
            }
        
            # Replace the ending display equation wrapper.
            if (match($0, /^\s*\\\]\s*$/) != 0) {
                # If there is only \] in the line.
                $0 = gensub(/^\s*\\\]\s*$/, prefix_spaces "```\n", 1);
                prefix_spaces = "";
            }
            else if (match($0, /\\\]\s*/) != 0) {
                # If \] is in a same line with the equation text, add prefix spaces first to
                # this line. Then move \] to the new line.
                $0 = gensub(/^(.*\\\]\s*)$/, prefix_spaces "\\1", 1);
                $0 = gensub(/\\\]\s*/, "\n" prefix_spaces "```\n", 1);
                prefix_spaces = "";
            }
        
            # Process bibliography item.
            $0 = gensub(/^(<div id="ref-.+)>$/, "\\1 markdown=\"1\">", 1);
        
            print prefix_spaces $0;
        }
        ```
    
    Then execute the command:
    
    ```text
    gawk -i inplace -f <awk-script> <markdown-file>
    ```
    
There is still the problem that math environments such as theorem, definition, proposition, etc. cannot be exported to markdown preserving the original format.

{{ "2024-05-13-convert-org-mode-contents-to-markdown" | backlink }}
