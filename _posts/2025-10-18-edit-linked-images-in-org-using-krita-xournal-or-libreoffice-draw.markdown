---
layout: post
title: "Edit linked images in Org using Krita, Xournal or LibreOffice Draw"
date: 2025-10-18
categories: [computer]
tags: [Emacs]
mathjax: false
---

I often use Krita, Xournal and LibreOffice Draw to make illustrations. They are then exported to PNG images and inserted as links in my Org Roam notes. With the following Elisp functions, I can now directly edit them in Krita, Xournal or LibreOffice Draw from Org. Also note that the scripts handle the case when multiple images can be exported from Xournal or LibreOffice Draw.

```elisp
(defun tjh/org-edit-image-with-krita ()
  "Edit a linked image using Krita. If the original kra file exists, edit this file."
  (interactive)
  (let* ((link (org-element-property :path (org-element-context)))
	 (krita-file (replace-regexp-in-string "png$" "kra" link)))
    (if (file-exists-p krita-file)
	(start-process-shell-command
	 "org-open-link" nil (format "%s '%s'" "krita" krita-file))
      (start-process-shell-command
       "org-open-link" nil (format "%s '%s'" "krita" link)))))

(defun tjh/org-edit-image-with-draw ()
  "Edit the original odg file in LibreOffice Draw associated with the current image. If there is only one image exported from the odg file, their base names are the same. Multiple images can be exported from a single odg file. If the odg file name is foo.odg, the image file names are assumed to be foo_<image-name>.png."
  (interactive)
  (let* ((link (org-element-property :path (org-element-context)))
	 (odg-file (replace-regexp-in-string "\\(_.*\\)*\\.png$" ".odg" link)))
    (if (file-exists-p odg-file)
	(start-process-shell-command
	 "org-open-link" nil (format "%s '%s'" "libreoffice" odg-file))
      (message "The image does have any associated odg file!"))))

(defun tjh/org-edit-image-with-xournal ()
  "Edit a linked image using Xournal and the image is exported from Xournal. Multiple images can be exported from a single Xournal file. If the Xournal file name is foo.xopp, the image file name is foo_export-1.png for example."
  (interactive)
  (let* ((link (org-element-property :path (org-element-context))))
    (setq link (replace-regexp-in-string
		"_export\\(-[0-9]+\\)*\\.png$" ".xopp" link))
    (start-process-shell-command
     "org-open-link" nil (format "%s '%s'" "xournalpp" link))))
```

{{ "2025-10-18-edit-linked-images-in-org-using-krita-xournal-or-libreoffice-draw" | backlink }}
