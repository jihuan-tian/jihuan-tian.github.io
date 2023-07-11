# This awk script is used for converting a directly written latex document to
# kramdown markdown format, which is the markdown engine I've adopted in Jekyll
# blog.

BEGIN {
    # Initialize the counter for four dolloar characters.
    four_dollars_count = 0;
    # Flag indicating being in a display math equation context.
    is_in_display_math = 0
}

{
    # Replace all dollar character with double dollar characters. Thus, there
    # will be four dollar characters, if there are display equations wrapped
    # between "$$ ... $$" in the original document.
    gsub(/\$/, "$$");
    # Convert the four dollar characters back to double dollar characters. Here,
    # we assume that for wrapping a display equation using double dollar
    # characters, they should appear in an independent line.
    number_of_four_dollars_in_current_line = gsub(/\$\$\$\$/, "$$");
    # We record the number of four dollar characters we've met. Based on its
    # parity, we check if a display equation starts or ends.
    four_dollars_count += number_of_four_dollars_in_current_line;

    if (number_of_four_dollars_in_current_line > 0) {
	if ((four_dollars_count % 2) == 1) {
	    # Display math equation starts.
	    is_in_display_math = 1;

	    print "\n", $0;
	}
	else {
	    # Display math equation ends.
	    is_in_display_math = 0;
	    
	    print $0, "\n";
	}
    }
    else {
	# After handling the dollar characters, we check other types of math
	# equation environments, which should be wrapped between double dollar
	# characters.
	if (is_in_display_math) {
	    end_display_math_reg = "^\\s*(\\\\\\])|(\\\\end{equation})|(\\\\end{equation\\*})|(\\\\end{align})|(\\\\end{align\\*})|(\\\\end{eqnarray})|(\\\\end{eqnarray\\*})\\s*$";

	    if ($0 ~ end_display_math_reg) {
		is_in_display_math = 0;
		
		# Remove the line "\]".
		gsub(/^\s*\\\]\s*$/, "");
		# Print out the closing double dollar characters on an
		# independent line.
		print $0, "\n$$\n";
	    }
	    else {
		# Convert any double dollars within a display math equation to
		# single dollar.
		gsub(/\$\$/, "$");

		print;
	    }
	}
	else {
	    start_display_math_reg = "^\\s*(\\\\\\[)|(\\\\begin{equation})|(\\\\begin{equation\\*})|(\\\\begin{align})|(\\\\begin{align\\*})|(\\\\begin{eqnarray})|(\\\\begin{eqnarray\\*})\\s*$";

	    if ($0 ~ start_display_math_reg) {
		is_in_display_math = 1;

		# Remove the line "\[".
		gsub(/^\s*\\\[\s*$/, "");
		# Print out the starting double double characters on an
		# independent line.
		print "\n$$\n", $0;
	    }
	    else {
		print;
	    }
	}
    }
}
