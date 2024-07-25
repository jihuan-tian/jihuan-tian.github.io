---
layout: post
title: Export Org contents to LaTeX file containing relative links
date: 2024-07-25
categories: [computer]
tags: [Emacs,Org-mode]
mathjax: false
---

I&rsquo;ve migrated my work journals to the `org-roam` root directory for building connections between notes (see [Migrated project work journals to org-roam root directory](personal-management.md)). But my formal LaTeX documents exported from Org mode are still placed in their respective project folders, which are outside of the `org-roam` root directory. Therefore, all relative links to images and other documents in LaTeX files should be converted with respect to a specific project folder. The path to the project folder is manually set as the variable `project-doc-dir` in the `scratch` buffer before export. By adding the following two functions to Org&rsquo;s export filter for hyperlinks `org-export-filter-link-functions`, those relative links can be automatically converted when Org contents are exported into a LaTeX buffer or file.

```elisp
;; Export Org to latex by converting relative links wrt a new directory.
(defun tjh/org-export-latex-convert-image-relative-links (link backend info)
  "Convert relative file links to absolute paths when exporting."
  (when (and (string-match "\\(\\includegraphics.*\\){\\(.*\\)}" link)
             (eq backend 'latex))
    (let ((include-cmd (match-string-no-properties 1 link))
          (file-path (match-string-no-properties 2 link)))
      (setq file-path (file-relative-name (expand-file-name file-path) project-doc-dir))
      (setq link (replace-regexp-in-string "\\includegraphics.*{.*}"
                                           (concat include-cmd "{" file-path "}")
                                           link t t))))
  link)

(defun tjh/org-export-latex-convert-href-relative-links (link backend info)
  (when (and (string-match "\\href{\\(.*?\\)}" link)
             (eq backend 'latex))
    (let ((file-path (match-string-no-properties 1 link)))
      (when (not (string-match "^http" file-path))
        (setq file-path (file-relative-name (expand-file-name file-path) project-doc-dir))
        (setq link (replace-regexp-in-string "\\href{.*?}"
                                             (concat "\href{" file-path "}")
                                             link t t)))))
  link)

(add-to-list 'org-export-filter-link-functions
             'tjh/org-export-latex-convert-image-relative-links)
(add-to-list 'org-export-filter-link-functions
             'tjh/org-export-latex-convert-href-relative-links)
```
