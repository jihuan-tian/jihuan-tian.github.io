---
layout: post
title: Create hyperlinks in Org mode
date: 2022-06-05
categories: [computer]
tags: [Emacs,Org-mode,知识联接]
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

# Insert a link to a specific position in a local PDF file

When the local file is a PDF document compiled from LaTeX, a link can be created with pinpoint accuracy to any LaTeX labels and `hypertargets`. Here a `hypertarget` is a macro in `Hyperref`, which can be used to create a named anchor like that in an HTML file. For example,

```latex
\hypertarget{anchor-name}{text}
```

Then insert the link to the local file as usual in Org mode and append it with `#anchor-name`.

To check existing named anchors or rather named destinations stored in the PDF file, use the `pdfinfo` command with the `-dests` option.

```text
-dests Print a list of all named destinations. If a pagerange is specified using "-f" and
"-l", only destinations in the page range are listed.
```

# Insert a link to a specific page in a local PDF file

Add a new item `("\\.pdf::\\([0-9]+\\)\\'" . "okular -p %1 %s")` to the alist variable `org-file-apps`. Then, when a hyperlink to a PDF file is appended with `::<page-no>`, the PDF file will be opened by Okular and directly jumps to the specified page.

# Insert a link to a specific position in a local LibreOffice file

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

# Insert a link to an Info node and help document

It is convenient to browse Info documents about various programs and libraries on Linux in Emacs. If we want to refer to a particular Info node from an Org note, it is possible to create a hyperlink to it using the link type `elisp:`.

First, we should get a copy of the Info node name by pressing `c` in an `Info` session. Then back in Org mode, we create a hyperlink as `[[elisp:(info "<info-node-name>")][<link-name>]]`.

Similarly, a hyperlink can also be created in Org which jumps to the help of a function, variable or key-bindings, etc. For example,

-   `[[elisp:(describe-function 'car)][elisp function car]]` links to the help document of the elisp function `car`;
-   `[[elisp:(describe-variable 'debug-on-error)][elisp variable debug-on-error]]` links to the help document of the lisp variable `debug-on-error`;
-   `[[elisp:(describe-key (kbd "C-c C-c"))][Key binding C-c C-c]]` links to the help document of the key binding `C-c C-c`.

In addition to using the link type `elisp:`, a simpler method is to use the hyperlink type `info:` for Info document and `help:` for help document. For example, `[[info:elisp#Introduction][Elisp Introduction section]]` links to the &ldquo;Introduction&rdquo; section in the Elisp Info document and `[[help:debug-on-error][debug-on-error]]` links to the help document for the elisp variable `debug-on-error`.

# Insert a link to a Joplin note

The external URL link for a Joplin note looks like this, which is not supported by Emacs Org mode.

    joplin://x-callback-url/openNote?id=a700a59f8a054e1aab97c296bf72fe3d

To make Org mode able to handle this link, we should add a new link type `joplin` by calling the `elisp` function `org-link-set-parameters`.

```emacs-lisp
(org-link-set-parameters
 ;; Name of the link type for Joplin node external URL link.
 "joplin"
 ;; Define the action when clicking on the link.
 :follow (lambda (url)
           ;; Open the link with the joplin script.
           (start-process "Joplin Session" nil "joplin" (concat "joplin:" url))))
```

In this function, we call the Joplin program using `start-process` and pass the full URL to it. The argument `url` of the `lambda` function associated with the `follow` action contains the string after the comma in the original link, i.e. `//x-callback-url/openNote?id=a700a59f8a054e1aab97c296bf72fe3d`. Therefore, we use `concat` to restore the original link. The second parameter of `start-process` is `nil`, which prevents Emacs from creating a buffer for the process.

# Other issues

## Cannot open a hyperlink to a local folder

Sometimes when I click on the hyperlink to a folder in the local file system, the message below appears in the mini buffer without opening the directory in Dired.

```text
Running less /directory/to/my/folder/...done
```

Solution: Add the item `(directory . emacs)` to the alist variable `org-file-apps`.

{{ "2022-06-05-create-hyperlinks-in-org-mode" | backlink }}
