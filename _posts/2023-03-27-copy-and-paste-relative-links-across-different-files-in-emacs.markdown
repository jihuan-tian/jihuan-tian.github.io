---
layout: post
title: Copy and paste relative links across different files in Emacs
date: 2023-03-27
categories: [computer]
tags: [Emacs,Org-mode,AUCTeX,LaTeX]
mathjax: false
---

As mentioned in [How to create relative hyperlinks in Org mode?]({% post_url 2021-02-28-how-to-create-relative-hyperlinks-in-org-mode %}), relative hyperlinks are indispensable for maintaining a bunch of inter-connected documents that have a fixed relative folder structure, when the whole folder tree is to be mounted at different locations on different computers. Therefore, I&rsquo;ve been pervasively using relative hyperlinks for referencing local images and files during my daily use of Org mode for summarizing numerical experiment results and taking technical notes, or use of AUCTeX for writing formal mathematical notes.

Quite often, the link to some local resource file has already been inserted as a relative hyperlink in another Org or LaTeX document, but the current document I&rsquo;m working on usually has a different relative path to the link target, the existing relative hyperlink should be transformed to an absolute path first, then converted to a new relative path with respect to the current document. Manual conversion is cumbersome and error-prone. I need to let Emacs help me with this.

In Org mode, when the cursor is placed on a hyperlink, the target URL can be extracted by first calling `org-element-context` to get the smallest Org element around the cursor, then calling `org-element-lineage` to get its ancestor of the `link` type. The obtained relative link can be expanded to an absolute path by calling `expand-file-name` with respect to the directory of the current Org file. Finally, push the absolute path into the kill ring by calling `kill-new`. These operations can be combined into the following function `tjh/org-get-absolute-file-link`.

```lisp
;; Get the absolute path of the relative file link.
(defun tjh/org-get-absolute-file-link (&optional arg)
  "Extract absolute file link from org-mode link and add it to kill ring."
  (interactive "P")
  (let* ((link (org-element-lineage (org-element-context) '(link) t))
          (type (org-element-property :type link))
          (relative-path (org-element-property :path link))
          (absolute-path (expand-file-name
                          relative-path (file-name-directory (buffer-file-name)))))
    (kill-new absolute-path)
    (message (concat "Absolute path: " absolute-path))))
```

After getting the absolute path, insert a new relative link in another Org file by pressing `C-u C-c C-l`. It should be noted that to enforce `org-insert-link` using relative path, set `org-link-file-path-type` to `'relative`.

In AUCTeX, a relative hyperlink is the first argument of the `\href` macro. Therefore, extracting the contents between the pair of curly brackets will get it. This is implemented in the following function `tjh/latex-get-absolute-file-link`. To paste this absolute link as a new relative link, there is no counterpart of `org-insert-link` in AUCTeX, then the function `tjh/paste-absolute-file-link-as-relative` is written to get the absolute path from the kill ring and convert it relative to the current default directory using `file-relative-name`.

```lisp
(defun tjh/latex-get-absolute-file-link (&optional arg)
  "Extract absolute file link from href and add it to kill ring."
  (interactive "P")
  (let (relative-path absolute-path beg end)
    (save-excursion
      (re-search-forward "}")
      (setq end (- (point) 1))
      (re-search-backward "{")
      (setq beg (+ (point) 1))
      (setq relative-path (buffer-substring beg end))
      (setq absolute-path (expand-file-name relative-path (file-name-directory (buffer-file-name))))
      (kill-new absolute-path)
      (message absolute-path))))

(defun tjh/paste-absolute-file-link-as-relative (&optional arg)
  "Paste absolute file link as relative link with respect to the file in the current buffer."
  (interactive "P")
  (let* ((absolute-path (current-kill 0))
         (relative-path (file-relative-name absolute-path)))
    (insert relative-path)))
```
