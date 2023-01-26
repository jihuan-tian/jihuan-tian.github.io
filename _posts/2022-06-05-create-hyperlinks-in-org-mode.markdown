---
layout: post
title: Create hyperlinks in Org mode
date: 2022-06-05
categories: [computer]
tags: [Emacs,知识联接, Org-mode]
mathjax: false
---

# Table of contents
{:.no_toc}

* toc starts here
{:toc}

This article summarizes several ways that I often use for insertion of hyperlinks in Emacs Org mode. They are very helpful for us to maintain inter-connected notes and documents.


# Insert a link to a local file

Press the hotkey `C-u C-c C-l` to insert a link to a file on your local computer. By setting the variable `org-link-file-path-type`&rsquo;s value as `relative`, the link is relative to the current directory. This is useful to make it effective, when the whole directory tree containing the file is migrated or synchronized to other mount points or devices.

Because I often use the `Helm` package for an interactive prompt of a file name or folder path, all the history files once selected via `Helm` can be quickly revisited. After pressing `C-u C-c C-l`, a further `C-c h` will trigger the `Helm` history. By navigating in the list of file names, we then come to the interested item. If it is to be used directly as the link target, press `F1`. If its name or path is to be modified before using, press `F2`. When the modification is finished, press `F1` to insert the final link.

# Insert a link to a directory

When the target local file is a folder not an ordinary file, even though the link created for it as above can be opened in Emacs `Dired` by pressing `C-c C-o`, it cannot be opened correctly in the PDF document that is compiled from the exported LaTeX file. This is because the link will be appended with a `.pdf` extension by the `Hyperref` LaTeX package. To solve problem, manually replace the link's identifying string `file` with `run` at the beginning of the link address.

<span class="timestamp-wrapper"><span class="timestamp">&lt;2022-07-15 Fri&gt; </span></span> However, when we export the Org contents into LaTeX using this method, there will be an error like this:

    user-error: Unable to resolve link: "run:path-to-the-directory/"

According to [StackExchange](https://tex.stackexchange.com/a/558242/84490), a definitive method is to keep the `file` prefix intact and append a dot to the link address. This will prevent `Hyperref` from *presumptuously* adding the `.pdf` extension.

# Insert a link to a specific position in a local file

When the local file is a PDF document compiled from LaTeX, a link can be created with pinpoint accuracy to any LaTeX labels and `hypertargets`. Here a `hypertarget` is a macro in `Hyperref`, which can be used to create a named anchor like that in an HTML file. For example,

```latex
\hypertarget{anchor-name}{text}
```

Then insert the link to the local file as usual in Org mode and append it with `#anchor-name`.

When the local file is a LibreOffice document, the method is same. Just open the navigation panel, from which any items in `Headings`, `Bookmarks` and `Hyperlinks` groups can be link to. The anchor names are their displayed names.


# Insert a link to other heading in the current Org file

Execute the command `helm-org-in-buffer-headings` (this depends on the MELPA package `helm-org`), which corresponds to the menu item `<tools> <Helm> <Org> <Org headlines in buffer>`. Then input the heading text pattern or navigate through the list. Finally, press `F4` to insert the link. At present, I bind this function locally with the shortcut key `F7`.

```emacs-lisp
(define-key org-mode-map [(f7)] 'helm-org-in-buffer-headings)
```


# Insert a link to other heading in a different Org file

There are two cases here. When the target Org file has been registered in the Org file list `org-agenda-files`, execute the command `helm-org-agenda-files-headings` (this depends on the MELPA package `helm-org`), which corresponds to the menu item `<tools> <Helm> <Org> <Org headlines in org agenda files>`. Then input the pattern or navigate through the list. Finally, press `F4` to insert the link. At present, I bind this function with the shortcut key `Shift+F7`.

```emacs-lisp
(define-key org-mode-map [(shift f7)] 'helm-org-agenda-files-headings)
```

When the target Org file has not been registered in `org-agenda-files`, we simply press `C-u C-c C-l` to insert a relative link to the file. Then we should manually append the target heading text prefixed by `::` to the link.
