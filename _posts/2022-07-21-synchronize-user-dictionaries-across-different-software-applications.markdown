---
layout: post
title: Synchronize user dictionaries across different software applications
date: 2022-07-21
categories: [computer]
tags: [Bash,Aspell,command]
mathjax: false
---

# Table of contents
{:.no_toc}

* toc starts here
{:toc}

My toolchain for programming and document writing includes Emacs, Eclipse, LibreOffice, Joplin and Freeplane. For web page browsing and email, I use Firefox and Thunderbird. All of them provide a spell check function. As time goes on, I&rsquo;ve added more and more rare words and terminology to them independently. To make the spell checking behavior consistent and remove the redundancy of adding a same word to all the applications, it is necessary to synchronize their user dictionaries. Since most of the time I work within Emacs, whose spell checker is `aspell`, I intend to copy all the words accumulated in `~/.aspell.en.pws` to the other applications.


# Synchronize to Joplin

The following script generates the Joplin customized dictionary by converting from the `aspell` dictionary.

```bash
word_list=`gawk '{if (NR > 1) print;}' ~/.aspell.en.pws`
dict_checksum=`echo -e "$word_list" | md5sum | cut -d "-" -f 1 | tr -d [:space:]`
echo -e -n "${word_list}\nchecksum_v1 = $dict_checksum" > ~/.config/Joplin/Custom\ Dictionary.txt
```

The procedure is described as this.

1.  Use `Gawk` to remove the header line `personal_ws-1.1 en num` in `~/.aspell.en.pws`. The remaining contents in the file are the list of words, one item per line.
2.  Calculate the MD5 checksum of the word list. Note that the variable `$word_list` should be wrapped within double quotes. Otherwise, it will be separated into a list of values by whitespace according to the interior field separator `IFS`. Another thing to be mentioned is that there should be no newline character at the end of the word list. Otherwise, the checksum will be considered incorrect by Joplin.
3.  Write out the list of words along with the checksum value to Joplin&rsquo;s custom dictionary file. N.B. The option `-n` of `echo` should be used, which prevents `echo` from adding a trailing newline character at the end of file, which is not accepted by Joplin.


# Synchronize to LibreOffice

The following script generates the dictionary used by LibreOffice.

```bash
echo -e "OOoUserDict1\nlang: <none>\ntype: positive\n---" > ~/.config/libreoffice/4/user/wordbook/aspell.dic
gawk '{if (NR > 1) print;}' ~/.aspell.en.pws >> ~/.config/libreoffice/4/user/wordbook/aspell.dic
```

The script first generates the header in the dictionary file.

    OOoUserDict1
    lang: <none>
    type: positive
    ---

Then it simply appends the word list from `aspell`. After that, in the configuration `Language Settings` → `Writing Aids`, `aspell` will appear in `User-defined dictionaries`, enable it.

![](/figures/2022-07-21_16-57-46-user-dict-in-libreoffice.png "Enable aspell dictionary in LibreOffice")


# Synchronize to Eclipse

In the configuration `General` → `Editors` → `Text Editors` → `Spelling`, we can select the file for user defined dictionary.

![](/figures/2022-07-21_16-58-24-user-dict-in-eclipse.png "User dictionary configuration in Eclipse")

In my case, I use `~/.eclipse.dict`. Then simply copy all `aspell` word list to into it.

```bash
gawk '{if (NR > 1) print;}' ~/.aspell.en.pws > ~/.eclipse.dict
```

# Synchronize to Freeplane

The method is the same as Eclipse with the dictionary file being `~/.config/freeplane/1.9.x/UserDictionary_en.txt`.

# Synchronize to Firefox and Thunderbird

The method is the same as Eclipse with the dictionary file being `persdict.dat` in the default profile folder of Firefox or Thunderbird. Its absolute path can be obtained by visiting `about:profiles` in Firefox or Thunderbird.

# Synchronize to KDE applications

KDE applications like Kate, Okular, etc. rely on the plugin `Sonnet` for spell checking, which uses `aspell` as its backend. Therefore, spell checking in KDE applications is consistent with that in Emacs and there is nothing more to do.

# Summary

The above user dictionary synchronizations coalesce into a definitive solution for a consistent and uniform spell checking in KDE Plasma on Linux.
