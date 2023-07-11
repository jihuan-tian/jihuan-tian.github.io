# This awk script is used for converting a Markdown document containing LaTeX
# which is exported from Org mode to kramdown markdown format, which is the
# markdown engine I've adopted in Jekyll blog.

{
    gsub(/(\\\()|(\\\))/, "$$");
    gsub(/\\\[/, "\n$$");
    gsub(/\\\]/, "$$\n");

    # Process bibliography item.
    $0 = gensub(/^(<div id="ref-.+)>$/, "\\1 markdown=\"1\">", 1);

    print;
}
