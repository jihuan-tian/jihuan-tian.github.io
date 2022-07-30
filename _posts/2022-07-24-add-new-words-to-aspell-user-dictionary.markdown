---
layout: post
title: Add new words to Aspell user dictionary
date: 2022-07-24
categories: [computer]
tags: [Aspell,Command,Bash]
mathjax: false
---

This script can be used to add a list of words on the command line to the user dictionary of Aspell, e.g. `~/.aspell.en.pws`.

```bash
for word in "$@"
do
    echo -e "*$word\n#" | aspell -a
    echo "$word is added!"
done 
```

The option `-a` lets `aspell` enter a [pipe mode](http://aspell.net/man-html/Through-A-Pipe.html), which supports the following commands. In our script, combining the commands `*word` and `#`, the output of `echo` is redirected to the standard input of `aspell`.

| \*word | Add a word to the personal dictionary                                   |
| &word  | Insert the all-lowercase version of the word in the personal dictionary |
| @word  | Accept the word, but leave it out of the dictionary                     |
| #      | Save the current personal dictionary                                    |
| ~      | Ignored for Ispell compatibility.                                       |
| +      | Enter TeX mode.                                                         |
| +mode  | Enter the mode specified by mode.                                       |
| -      | Enter the default mode.                                                 |
| !      | Enter terse mode                                                        |
| %      | Exit terse mode                                                         |
| ^      | Spell-check the rest of the line                                        |
