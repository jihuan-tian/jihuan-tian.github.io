# This awk script is used for correcting LaTeX wrappers in the markdown
# document, which is converted from a LaTeX document via pandoc. This LaTeX
# document is exported from Org model.

{
    # Replace inline equation wrappers.
    gsub(/(\\\()|(\\\))/, "$$");
    # Replace display equation wrappers.
    gsub(/\\\[/, "\n$$");
    gsub(/\\\]/, "$$\n");

    # Process bibliography item.
    $0 = gensub(/^(<div id="ref-.+)>$/, "\\1 markdown=\"1\">", 1);

    print;
}
