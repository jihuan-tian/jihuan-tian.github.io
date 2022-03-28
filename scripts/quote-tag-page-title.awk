# This script wrap the title name for tag page with double quotation
# marks.

{
    print gensub("^title:\\s*(.+)\\s*$", "title: \"\\1\"", 1, $0);
}
