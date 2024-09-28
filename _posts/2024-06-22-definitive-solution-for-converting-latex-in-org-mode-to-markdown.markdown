---
layout: post
title: Definitive solution for converting LaTeX in Org mode to markdown
date: 2024-06-22
categories: [computer]
tags: [Org-mode,LaTeX,Markdown]
mathjax: false
---

Finally, I switch to `make4ht` for converting LaTeX in Org mode to markdown.

Previously, when I wanted to publish some Org contents including LaTeX math equations to either GitHub Jekyll blog (equations are rendered by MathJax and the kramdown grammar is used) or GitLab web page (equations are rendered by KaTeX), I followed this procedure:

1.  Export Org mode contents to LaTeX.
2.  Convert LaTeX to GFM markdown via pandoc. In this page, `--bibliography=<bibtex-file>` option is added to pandoc. Then Bibtex citations in the original LaTeX document will be formatted to similar text as in LaTeX, such as `(Steinbach 2007)` if the Chicago citation style is used. The list of references will be generated into something as below.
    
    ```text
    # References
    
    <div id="refs" class="references hanging-indent">
    
    <div id="ref-ErichsenEfficient1998" markdown="1">
    
    Erichsen, Stefan, and Stefan A. Sauter. 1998. “Efficient Automatic
    Quadrature in 3-d Galerkin Bem.” *Computer Methods in Applied Mechanics and Engineering*, Papers presented at the seventh conference on
    numerical methods and computational mechanics in science and
    engineering, 157 (3): 215–24.
    <https://doi.org/10.1016/S0045-7825(97)00236-3>.
    
    </div>
    
    <div id="ref-SteinbachNumerical2007" markdown="1">
    
    Steinbach, Olaf. 2007. *Numerical Approximation Methods for Elliptic Boundary Value Problems: Finite and Boundary Elements*. Springer Science
    & Business Media.
    
    </div>
    
    </div>
    ```
3.  Use an [Awk script]({% post_url 2024-05-13-convert-org-mode-contents-to-markdown %}) to convert LaTeX equation wrappers to be suitable for MathJax or KaTeX.

Unfortunately, due some unknown cause, pandoc cannot process bibliography anymore and I don&rsquo;t know if this is related to my system upgrade from Debian Bullseyes to Bookworm. Meanwhile, the markdown export functionality provided by Org mode is even poorer than pandoc. Since I do not want to invest time to write a markdown exporter in Elisp at the moment, I have also tried other alternatives, such as `TeXmacs` with the [tm2md](https://github.com/PikachuHy/texmacs-converter-tm2md/tree/master) plugin, neither can bibliography be handled and the generated markdown text is far from satisfying. Finally, I resorted to `make4ht`, which converts LaTeX to html. So far as I know, `make4ht` is the best document conversion tool which can preserve the original LaTeX typesetting. Its command line usage is like this.

```text
make4ht -f html5-css <tex-file.tex> "mathjax,fn-in"
bibtex <tex-file.aux>
make4ht -f html5-css <tex-file.tex> "mathjax,fn-in"
```

Then open the generated HTML file and use the following Elisp script to correct display equations:

```elisp
(defun tjh/correct-make4ht ()
  (interactive)
  (goto-char (point-min))
  (replace-string "\\begin {equation" "\\begin{equation")
  (goto-char (point-min))
  (replace-string "\\end {equation" "\\end{equation"))
```

Finally, extract the main contents from the HTML file (including the table of contents, since the `[toc]` markdown directive is not recognized when the file extension is `html`) and add the markdown preamble. To prevent some HTML tags are processed by Jekyll first which makes further HTML rendering incorrect, the file should be saved with the `html` extension. It is fortunate that Liquid markup language is still supported. Hence, link to an existing post can be conveniently inserted by using the `post_url` command.

I&rsquo;ve already wasted much time studying the usage of Org mode, pandoc and Awk etc., tuning their parameters, previewing and testing the conversion quality. Even though these tools give me the freedom and long term stability of my note and writing system, wasting time on tools instead of directly working on the project and solving problems is definitely a pitfall. To realize this point and make good balance between them, I have spent many years.

{{ 2024-06-22-definitive-solution-for-converting-latex-in-org-mode-to-markdown | backlink }}
