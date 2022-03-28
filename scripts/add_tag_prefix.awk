# This script add a "Tag: " prefix to the existing tag page. N.B.
# Because there is a white space between "Tags:" and the tag name, to
# prevent parsing errors, double quotation marks should be used to
# wrap them.

{
    print gensub("^title:\\s*(\\S+)\\s*$", "title: \"Tag: \\1\"", 1, $0);
}
