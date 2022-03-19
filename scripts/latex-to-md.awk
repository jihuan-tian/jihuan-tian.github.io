BEGIN {
    # Initialize the counter for four dolloar signs.
    four_dollars_count = 0;
    # Flag indicating being in a display math equation context.
    is_in_display_math = 0
}

{
    gsub(/\$/, "$$");
    number_of_four_dollars_in_current_line = gsub(/\$\$\$\$/, "$$");
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
	if (is_in_display_math) {
	    end_display_math_reg = "^\\s*(\\\\end{equation})|(\\\\end{equation\\*})|(\\\\end{align})|(\\\\end{align\\*})|(\\\\end{eqnarray})|(\\\\end{eqnarray\\*})\\s*$";

	    if ($0 ~ end_display_math_reg) {
		is_in_display_math = 0;
		
		print $0, "\n$$\n";
	    }
	    else {
		# Convert double dollars within a display math equation to
		# single dollar.
		gsub(/\$\$/, "$");

		print;
	    }
	}
	else {
	    start_display_math_reg = "^\\s*(\\\\begin{equation})|(\\\\begin{equation\\*})|(\\\\begin{align})|(\\\\begin{align\\*})|(\\\\begin{eqnarray})|(\\\\begin{eqnarray\\*})\\s*$";

	    if ($0 ~ start_display_math_reg) {
		is_in_display_math = 1;

		print "\n$$\n", $0;
	    }
	    else {
		print;
	    }
	}
    }
}
