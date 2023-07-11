{
    $0 = gensub(/^(\s*\\begin{aligned}\s*)$/, "\\\\[\n\\1", 1);
    $0 = gensub(/^(\s*\\end{aligned}\s*)$/, "\\1\n\\\\]", 1);

    print;
}
