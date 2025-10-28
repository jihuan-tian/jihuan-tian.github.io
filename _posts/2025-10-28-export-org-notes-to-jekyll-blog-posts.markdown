---
layout: post
title: "Export Org notes to Jekyll blog posts"
date: 2025-10-28
categories: [computer]
tags: [Org-mode,Jekyll]
mathjax: false
---

I write notes in Org Roam. I use the following Elisp functions to export my notes to a blog post in Jekyll.

`tjh/org-copy-images-in-org-to-folder` is used to copy linked images in a note to the `figures` folder in my blog.

```elisp
(defun tjh/org-copy-images-in-org-to-folder (scope dest-dir)
  "Copy all image files referenced by links in the current Org subtree or the whole buffer to DEST-DIR.
Creates DEST-DIR if it doesn’t exist."
  (interactive
   (list
    ;; Org scope selection
    (intern (completing-read "Scope: " '("subtree" "buffer") nil t))
    ;; Export directory
    (read-directory-name "Destination directory: ")))
  (let ((case-fold-search t)
        (image-extensions '("png" "jpg" "jpeg" "gif" "svg" "tiff" "bmp" "webp"))
        files
	end)
    ;; Find all links in the current Org subtree or whole buffer.
    (save-excursion
      (if (eq scope 'subtree)
	  (org-back-to-heading t)
	(goto-char (point-min)))
      (if (eq scope 'subtree)
	  (setq end (save-excursion (org-end-of-subtree t t)))
	(setq end (point-max)))
      (while (re-search-forward org-link-bracket-re end t)
        (let ((link (org-element-context)))
          (when (eq (org-element-type link) 'link)
            (let* ((type (org-element-property :type link))
                   (path (org-element-property :path link))
		   (ext))
	      (when (member type '("file" "attachment"))
		(setq ext (downcase (file-name-extension path)))
                (when (member ext image-extensions)
                  (push (expand-file-name path) files))))))))
    
    ;; Copy them to the destination
    (when files
      (unless (file-exists-p dest-dir)
        (make-directory dest-dir t))
      (dolist (f files)
        (when (file-exists-p f)
          (copy-file f (expand-file-name (file-name-nondirectory f) dest-dir) t)))
      (message "Copied %d image(s) to %s" (length files) dest-dir))))
```

I execute `tjh/org-export-org-to-md-as-new-blog` to copy images and create the markdown file via `with-temp-file`. In the markdown file, I first generate a preamble, where the value of the `date` field is acquired from the `CREATED` property of the note. Then insert the markdown text returned from `org-export-as`. At the end of the markdown file, a backlink is generated which can be processed by Jekyll (see [Enable backlinks in Jekyll blog]({% post_url 2024-09-28-enable-backlinks-in-jekyll-blog %})). Finally, a `BLOG` property is created in the original note whose value is a link to the markdown file.

```elisp
(defun tjh/org-export-org-to-md-as-new-blog (scope)
  "Export the current Org subtree or whole buffer to a new markdown blog post. Create a BLOG property which contains a link to the blog post. Front matter and backlink are automatically inserted int the blog post."
  (interactive
   (list
    ;; Org scope selection
    (intern (completing-read "Scope: " '("subtree" "buffer") nil t))))
  ;; Before export the subtree to markdown, we copy all linked figures in the
  ;; subtree to the "figures" folder in the blog.
  (tjh/org-copy-images-in-org-to-folder scope
   (concat (concat (getenv "blog") (f-path-separator) "figures")))
  (let* ((filename-ext "markdown")
	 ;; Markdown contents as a string.
	 (exported-md (org-export-as 'gfm (eq scope 'subtree) t))
	 (time-string (org-entry-get (point) "CREATED"))
	 (heading-text
	  (if (eq scope 'subtree)
	      (substring-no-properties
	       (org-get-heading t t t t))
	    (org-get-title))))
    (unless time-string
      (user-error "CREATE property of the subtree is missing!"))
    (string-match "<\\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}\\).*>" time-string)
    (let* ((created-time (match-string 1 time-string))
	   ;; Generate blog post base name.
	   (blog-post-basename
	    (concat created-time "-"
		    (replace-regexp-in-string "," ""
					      (replace-regexp-in-string " +" "-"
									(downcase heading-text)))))
	   (blog-post-filename (concat blog-post-basename "." filename-ext))
	   (blog-post-fullname (file-relative-name
				(concat (getenv "blog") (f-path-separator)
					"_posts" (f-path-separator)
					blog-post-basename "." filename-ext)))
	   (blog-post-relative-link (format "[[file:%s]]" blog-post-fullname)))
      (org-set-property "BLOG" blog-post-relative-link)
      ;; Generate the blog post contents.
      (with-temp-file
	  blog-post-fullname
	(insert
	 (format "---\nlayout: post\ntitle: \"%s\"\ndate: %s\ncategories: []\ntags: []\nmathjax: false\n---\n\n" heading-text created-time))
	(insert exported-md)
	(insert
	 (format "\n\n{{ \"%s\" | backlink }}" blog-post-basename))
	;; Modify the path to figures.
	(goto-char (point-min))
	(replace-string "![img](/figures/" "![img](/figures/"))
      (org-open-file blog-post-fullname))))
```

{{ "2025-10-28-export-org-notes-to-jekyll-blog-posts" | backlink }}
