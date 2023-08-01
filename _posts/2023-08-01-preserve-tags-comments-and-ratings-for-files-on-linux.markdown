---
layout: post
title: Preserve tags, comments and ratings for files on Linux
date: 2023-08-01
categories: [computer]
tags: [rsync,KDE,command,Dolphin]
mathjax: false
---

Tags, comments and ratings information for files on Linux are stored as the file extended attributes instead of in a centralized database. Such information can be set and modified directly within the Dolphin file manager, which is internally handled by the `baloo-kf5` Debian package.

Such information can also be acquired via the `getfattr` command. For example,

```text
getfattr -d 2013-10-13.odt 
# file: 2013-10-13.odt
user.baloo.rating="8"
user.xdg.comment="This is a test comment."
user.xdg.tags="education,reading"
```

Unluckily, file copying and pasting within Dolphin does not preserve the above extended file attributes. We can only achieve this by using `cp` with the `--preserve=xattr` option in the command line. For me, I also regularly use `rsync` to perform file backup and synchronization, then the `-X` option should be appended to `rsync` in order to copy the extended file attributes.

# References

-   [Tagging your files](https://vhanda.in/blog/2014/07/tagging-your-files/)
-   [Guidelines for extended attributes](https://www.freedesktop.org/wiki/CommonExtendedAttributes/)
-   <https://www.lesbonscomptes.com/pages/extattrs.html>
