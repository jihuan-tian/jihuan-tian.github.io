---
layout: post
title: Migrated project work journals to org-roam root directory
date: 2024-07-19
categories: [computer]
tags: [Org-mode]
mathjax: false
---

`org-roam` does not support Org files scattered in different folders which do not share a common ancestor. Therefore, I have to migrate my project work journals to the `org-roam` root directory. Since I still prefer to store project resources including figures, illustrations, scanned documents, mindmaps etc. into the project&rsquo;s own folder, all the relative links to these resources in the work journals should be converted with respect to the `org-roam` root directory.

With the help of ChatGPT, I wrote the following Elisp function to achieve the above purpose. Note that this script also works for a link to Org heading like this `[[file:../../file.org::heading text]]`.

```elisp
(defun tjh/is-relative-path (path)
  "Check if PATH is a relative path."
  (not (file-name-absolute-p path)))

(defun tjh/replace-string-in-region (start end replacement)
  "Replace the string between START and END with REPLACEMENT."
  (goto-char start)
  (delete-region start end)
  (insert replacement))

(defun tjh/org-migrate-relative-links (target-migration-dir)
  (interactive "DTarget migration directory: ")
  (goto-char (point-min))
  ;; Search each link in the Org file.
  (while (re-search-forward org-link-bracket-re nil t)
    (let* ((link-start (match-beginning 0))
           (link-end (match-end 0))
           (url (match-string-no-properties 1))
           (actual-url url)
           (desc (match-string-no-properties 2))
           (link (org-element-lineage (org-element-context) '(link) t))
           (type (org-element-property :type link))
           (has-run-prefx nil))

      (if (string= type "file")
          (progn
            (if (string-match "^file:run:\\(.*\\)" url)
                ;; Remove the prefix "file:run:"
                (progn
                  (setq actual-url (substring url 9))
                  (setq has-run-prefx t))
              ;; Remove the prefix "file:"
              (setq actual-url (substring url 5)))

            ;; We only transform relative path.
            (if (tjh/is-relative-path actual-url)
                (progn
                  (setq actual-url
                        (file-relative-name
                         (expand-file-name actual-url)
                         target-migration-dir))
                  ;; Prepend the "run:" prefix if needed.
                  (if has-run-prefx
                      (setq actual-url (concat "run:" actual-url)))

                  (if desc
                      (tjh/replace-string-in-region
                       link-start
                       link-end
                       (format "[[%s:%s][%s]]" type actual-url desc))
                    (tjh/replace-string-in-region
                     link-start
                     link-end
                     (format "[[%s:%s]]" type actual-url))))))))))
```

After that, I assigned a unique id to each headings in all Org files under a specified directory. As long as a heading has an id, it will be recognized by `org-roam` as a piece of independent note.

```elisp
;; Add ids to all headings of the current Org file.
(defun tjh/org-add-ids-to-all-headings ()
  "Add IDs to all headings in the current buffer."
  (interactive)
  (org-map-entries 'org-id-get-create))

;; Add ids to all headings in all Org files under a directory.
(defun tjh/org-add-ids-to-org-files (directory)
  "Add IDs to all headings in all Org files in DIRECTORY."
  (dolist (file (directory-files-recursively directory "\\.org$"))
    (with-current-buffer (find-file-noselect file)
      (tjh/org-add-ids-to-all-headings)
      (save-buffer))))
```

Before using `org-roam`, I inserted internal links between different Org notes via the default mechanism provided by Org `org-store-link`. However, if the heading text is changed, all links to it will fail. Now with the above assigned indices, heading text changing will not invalid the links, which is much more robust. Setting the variable `org-id-link-to-org-use-id` to `t`, calling `org-store-link` will generate a id link.

I do not like the Zettelkasten concept. It would produce a lot of scattered small Org files, which are difficult to manage and browse. And they cannot be directly displayed in Org agenda. Therefore, I still put my notes belong to a same category into a same Org file.

The topology among my notes and journals can be visualized via `org-roam-ui`.

![img](/figures/2024-07-19-org-roam-all-note-links.png)
