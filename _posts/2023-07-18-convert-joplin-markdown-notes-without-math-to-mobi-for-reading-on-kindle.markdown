---
layout: post
title: Convert Joplin Markdown notes without math to mobi for reading on Kindle
date: 2023-07-18
categories: [computer]
tags: [Kindle,Joplin,Pandoc]
mathjax: false
---

When there are no mathematical symbols or equations in Joplin notes, we had better use the mobi format to read them on Kindle. At present, the conversion is performed in three steps.

1.  Export Joplin notes to `Markdown + Front Matter`.
2.  Convert the exported Markdown files to the epub format.
    
    ```bash
    #!/bin/bash
    # @file: md2epub.sh
    export https_proxy=http://192.168.0.100:1080; export http_proxy=http://192.168.0.100:1080; pandoc -f markdown -t epub --epub-metadata="$2" -o "${1%md}epub" "$1"
    ```
    
    In the above Bash script, before executing `pandoc`, https and http proxy servers are specified, which are used for downloading images from abroad. The pandoc option `--epub-metadata` is used to specify the language information in the converted document. According to [here](https://pandoc.org/chunkedhtml-demo/11.1-epub-metadata.html), the language should be in the [BCP7](https://www.rfc-editor.org/info/bcp47) format, such as `en-US`, `en-GB`, `zh-CN`, `zh-TW`, etc. From [Wikipedia](https://en.wikipedia.org/wiki/IETF_language_tag), a list of common language tags can be found. The metadata file is in XML format as below.
    
    ```xml
    <dc:language>en-GB</dc:language>
    ```
    
    The above language configuration is very important. Otherwise, when the finally obtained mobi file is opened in Kindle, assume it is an English article, no English fonts can be configured but only Chinese fonts.
3.  Convert the epub files to mobi format by using the `ebook-convert` command provided by Calibre.
    
    ```bash
    ebook-convert "${1%md}epub" "${1%md}mobi" --no-inline-toc
    ```

Combine step 2 and step 3 into a single script:

```bash
#!/bin/bash
# @file: md2mobi.sh
md2epub.sh "$1" "$2"
ebook-convert "${1%md}epub" "${1%md}mobi" --no-inline-toc
```

To convert all the Markdown files in the current folder, execute this command:

```bash
ls *.md | xargs -I "{}" md2mobi.sh "{}" ../en-gb-metadata.xml
```
