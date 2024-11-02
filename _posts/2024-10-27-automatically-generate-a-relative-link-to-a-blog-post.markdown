---
layout: post
title: Automatically generate a relative link to a blog post
date: 2024-10-27
categories: [computer]
tags: [Emacs, Org-mode]
mathjax: false
---

I use Org mode for taking notes, which are organized in different levels of headings. I use Jekyll as my blog system and its articles are exported from related headings in my Org mode files. I use the following Elisp function `tjh/org-blog-default-link` to automatically generate a file name for a blog post and also create a `BLOG` property associated with the heading, which contains a relative link to the blog post file.

```elisp
(defun tjh/org-blog-default-link (filename-ext)
  "Create BLOG property and add the relative link to the blog post associated with the current heading."
  (interactive
   (list (read-string "Blog post file extension: " "markdown")))
  (if (> (length filename-ext) 0)
      (save-excursion
        (org-back-to-heading t)
        (let ((heading-text
               (concat (format-time-string "%Y-%m-%d-") (replace-regexp-in-string " +" "-" (downcase (org-get-heading t t t t)))))
              (blog-post-dir (getenv "post"))
              (blog-post-filename)
              (blog-post-relative-link))
          (if (> (length heading-text) 0)
              (progn
                (setq blog-post-relative-link (format "[[file:%s]]" (file-relative-name (concat blog-post-dir (f-path-separator) heading-text "." filename-ext))))
                (org-set-property "BLOG" blog-post-relative-link)
                (setq blog-post-filename (concat heading-text "." filename-ext))
                (kill-new blog-post-filename)
                (message "Copied blog post file name: %s" blog-post-filename)))))))
```

Then I use the function `tjh/org-blog-open` to open the blog post file, when the cursor is at the heading or within the contents below this heading.

```elisp
(defun tjh/org-blog-open()
  "Open the blog post whose link is stored as the :BLOG property"
  (interactive)
  (save-excursion
    (org-back-to-heading t)
    (let ((element (org-element-at-point))
          (blog-file))
      (when (eq (org-element-type element) 'headline)
        (setq blog-file (org-element-property :BLOG element))
        (if (and blog-file (not (string-empty-p blog-file)))
            (org-open-file (replace-regexp-in-string "file:" "" (replace-regexp-in-string "[\]\[]" "" blog-file)))
          (message "There is no blog associated with this item!"))))))
```

With these two functions, my Org notes and Jekyll blog are intimately connected.

{{ "2024-10-27-automatically-generate-a-relative-link-to-a-blog-post" | backlink }}
