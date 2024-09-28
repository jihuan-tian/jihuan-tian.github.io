---
layout: post
title: Batch download images from Xiaohongshu
date: 2022-12-31
categories: [computer]
tags: [command]
mathjax: false
---

1.  Open Firefox developer tools.
2.  Search the HTML class name `change-pic` and delete it.
3.  Press `C-S-c` to re-pick the HTML element containing the image area.
4.  Select the parent HTML node of the currently focused node, which is something like `<ul class="slide" data-v-f3680c6c="">`.
5.  Press `C-c` to copy the HTML code of the node and save it to a file.
6.  Use a combination of several commands, `grep`, `sed`, `xargs` and `wget`, to extract image URLs and download all of them.
    
    ```bash
    grep -P -o '(?<=url\().*?(?=\))' album.html | sed "s/&quot;/\"/g" |sed "s/\/\//https:\/\//" | xargs wget
    ```
    
    N.B. In the pipe-concatenated commands above, `grep` uses the option `-P` to enable Perl compatible regular expressions. Its option `-o` will output only the matched patterns. In the regular expression `(?<=url\().*?(?=\))`, `(?<=url\()` is a positive look-behind assertion, while `(?=\))` is a positive look-ahead assertion ([reference](https://www.perlmonks.org/?node_id=518444)). `.*?` matches any characters between a pair of brackets `()` in a non-greedy mode. The total effect of this regular expression is to extract the url from the string below.
    
    ```text
    url(&quot;//ci.xiaohongshu.com/8f9e2cf5-ea58-ef7f-b3bb-65e8ede2798c?imageView2/2/w/1080/format/jpg&quot;)
    ```
    
    `sed` first replaces HTML quote `&quot;` with `"` and then `//` with `https://`. Finally, `xargs` passes each line of extracted URL to `wget` which downloads the image.

{{ "2022-12-31-batch-download-images-from-xiaohongshu" | backlink }}
