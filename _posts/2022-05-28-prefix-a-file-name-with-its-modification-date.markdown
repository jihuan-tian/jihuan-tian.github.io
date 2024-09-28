---
layout: post
title: Prefix a file name with its modification date
date: 2022-05-28
categories: [computer]
tags: [Linux,Bash,command]
mathjax: false
---

The following simple Bash script adds a year-month-date string to the file name, which makes its time stamp more apparent in a file explorer. Also note that in the `grep` command, the Perl-compatible regular expression is adopted.

```bash
#!/bin/bash

modification_date=$(ls -l "$1" --full-time | grep -P "\d{4}-\d{2}-\d{2}" -o)
mv "$1" "$modification_date-$1"
```

{{ "2022-05-28-prefix-a-file-name-with-its-modification-date" | backlink }}
