---
layout: post
title: Open hyperlink to Joplin note from PDF
date: 2022-07-30
categories: [computer]
tags: [Joplin,知识联接,command]
mathjax: false
---

In [this note]({% post_url 2022-07-30-create-link-to-joplin-notes-in-emacs-org-mode %}), a link to a Joplin note can be created and opened in Emacs Org mode based on its external URL. However, when the Org document is exported to a LaTeX file, the original link, for example,

    joplin://x-callback-url/openNote?id=62cef9486b08411ea8c5fcd49d9cd4ea

becomes

```latex
\href{//x-callback-url/openNote?id=a700a59f8a054e1aab97c296bf72fe3d}{link name}
```

After compiling the LaTeX file into a PDF file, this link will be converted to

    file://x-callback-url/openNote%3Fid=a700a59f8a054e1aab97c296bf72fe3d.pdf

Of course, this is invalid. When clicking it in Okular, the following error message dialog appears.

![img](/figures/2022-07-30_21-25-35-joplin-link-error-in-pdf.png)

According to [here](http://x-callback-url.com/), `x-callback-url` is a protocol for iOS developers to expose and document the methods they make available to other apps, which cannot be supported on Linux. Therefore, it is necessary for us to copy out the note id, such as `a700a59f8a054e1aab97c296bf72fe3d` as above, then manually start Joplin to open this note. This process can be simplified by the following script, which either gets the command line argument or the content in the [primary clipboard]({% post_url 2022-05-28-clipboards-in-X-Window-System %}) as the note id.

```bash
if [ $# = "1" ]; then
  # Use the first argument on the command line as the note id.
  note_id=$1
else
  # Use the clipboard content as the note id.
  note_id=`xclip -selection primary -o`
fi

joplin "joplin://x-callback-url/openNote?id=$note_id"
```

In this way, by simply double clicking on the note id in the error message dialog, then running this script, we can directly jump to the note in Joplin.

{{ 2022-07-30-open-hyperlink-to-joplin-note-from-pdf | backlink }}
