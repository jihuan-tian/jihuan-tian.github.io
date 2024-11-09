#!/usr/bin/gawk -f

# Begin the script with initial conditions
BEGIN {
    inside = 0       # Tracks if we are inside the YAML front matter
    found_mathjax = 0  # Flag to check if mathjax: true is already present
}

# Detect start and end of YAML front matter
/^---$/ {
    if (inside == 0) {
        inside = 1
        print
        next
    }
    
    if (inside == 1 && found_mathjax == 0) {
        print "mathjax: true"
        found_mathjax = 1
    }
    
    inside = 0
}

# Check each line within the front matter block for "mathjax: true"
/^[^-]/ {
    if (inside == 1 && /mathjax: true/) {
        found_mathjax = 1
    }
}

# Print each line as is
{
    print
}
