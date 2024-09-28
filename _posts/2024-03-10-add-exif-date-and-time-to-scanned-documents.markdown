---
layout: post
title: Add EXIF date and time to scanned documents
date: 2024-03-10
categories: [computer]
tags: [command,scanner]
mathjax: false
---

The following method is only applicable to the first transfer of scanned documents from CamScanner on my iPhone to my Linux workstation.

I rely on CamScanner to automatically crop and adjust color of my scanned documents. They are firstly processed by CamScanner, then automatically saved to iPhone&rsquo;s photo album. After that, I manually upload them to my Linux Samba server. These processed images do not have date/time information in the EXIF metadata, which makes them not be sorted by time in an image viewer such as Gwenview. Therefore, after first transfer of these images to my Linux workstation, I need to use the modification time of these files as their approximate EXIF date/time.

Procedures

1.  Use `stat` to get the modification time in the format since epoch.
2.  Use `date` to generate the date/time string used for EXIF.
3.  Use `exiftool` to set the `AllDates` field in EXIF.

Bash script

```bash
#!/bin/bash

file_modification_time_stamp=`stat -c %Y "$1"`
# Modification time string is in the EXIF time format
file_modification_time_string=`date -d "@$file_modification_time_stamp" "+%Y:%m:%d %H:%M:%S"`

exiftool -overwrite_original -AllDates="$file_modification_time_string" "$1"
```

Run the script for all files in a folder:

```bash
ls | xargs -I '{}' add-time-to-scanning.sh '{}'
```

{{ "2024-03-10-add-exif-date-and-time-to-scanned-documents" | backlink }}
