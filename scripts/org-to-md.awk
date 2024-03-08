# This awk script is used for correcting LaTeX wrappers in the markdown
# document, which is exported from Org mode.

BEGIN {
    start_display_math_reg = "^\\s*(\\\\\\[)|(\\\\begin{equation})|(\\\\begin{equation\\*})|(\\\\begin{align})|(\\\\begin{align\\*})|(\\\\begin{eqnarray})|(\\\\begin{eqnarray\\*})\\s*$";
    end_display_math_reg = "^\\s*(\\\\\\])|(\\\\end{equation})|(\\\\end{equation\\*})|(\\\\end{align})|(\\\\end{align\\*})|(\\\\end{eqnarray})|(\\\\end{eqnarray\\*})\\s*$";
}

{
    # Replace inline equation wrappers.
    gsub(/(\\\()|(\\\))/, "$$");

    # Process bibliography item.
    $0 = gensub(/^(<div id="ref-.+)>$/, "\\1 markdown=\"1\">", 1);

    if ($0 ~ start_display_math_reg) {
	# Remove the line "\[", if there is any.
	gsub(/^\s*\\\[\s*$/, "");
	# Print out the starting double double characters on an
	# independent line.
	print "\n$$\n", $0;
    }
    else if ($0 ~ end_display_math_reg) {
	# Remove the line "\]", if there is any.
	gsub(/^\s*\\\]\s*$/, "");
	# Print out the closing double dollar characters on an
	# independent line.
	print $0, "\n$$\n";
    }
    else
    {
	print;
    }
}
