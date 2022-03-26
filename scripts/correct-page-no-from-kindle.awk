BEGIN {
    is_page_no_line_found = 0;
}

{
    if (/^\s*>\s*P[0-9]+$/) {
	# When the line contains only page number, set the output
	# record separator to empty string, so that the newline is
	# deleted.
	ORS = "";
	print;
	is_page_no_line_found = 1;
    }
    else {
	# Set the output record separator to the default newline
	# character.
	ORS = "\n";

	if (is_page_no_line_found) {
	    # Remove the prefix character ">".
	    gsub("^>", "");
	    print;
	    
	    is_page_no_line_found = 0;
	}
	else {
	    print;
	}
    }
}
