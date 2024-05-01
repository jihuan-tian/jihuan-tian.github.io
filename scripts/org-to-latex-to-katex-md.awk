# This awk script is used for correcting LaTeX wrappers in the markdown document
# with KaTeX to be used in Gitlab, which is converted from a LaTeX document via
# pandoc. This LaTeX document is exported from Org mode.
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
