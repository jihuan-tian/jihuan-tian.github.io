# This script removes the permalink line in the front matter.

{
    if (!/^permalink:.*$/) {
	print;
    }
}
