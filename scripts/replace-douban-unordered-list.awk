# Replace unordered list symbols used in previous Douban articles with
# the markdown asterisk symbol.

{
    # First level
    if (!gsub("^•", "*")) {
	# Second level
	if (!gsub("^◦", "  *")) {
	    # Third level
	    if (!gsub("^▪", "    *")) {
		# Fourth level
		if (!gsub("^▫", "      *")) {
		    # Fifth level
		    gsub("\\\\-", "        *");
		}
	    }
	}
    }

    print;
}
