---
layout: post
title: Visiting PDF files in Zotero library from Emacs Org mode
date: 2022-08-06
categories: [computer]
tags: [Emacs,Org-mode,Zotero]
mathjax: false
---

For academic writing and note taking in Emacs Org mode, I have been relying on the `org-ref` package (which can be installed from Melpa) to insert bibliography citations, visit associated PDF files and take notes. The backend bibliography database is actually a BibTeX file, which is exported from my Zotero library with the help of the `Better BibTex` extension. `org-ref` also depends on the `bibtex-completion` package, which enables me to interact with the bibliography database efficiently.

The following variables need to be configured for `org-ref`.

```lisp
;; The root folder, which is the reference for generating relative paths for
;; those linked PDF files.
(setq zotero-base-directory-for-linked-pdf "/home/jihuan/文档/Documents/academic/Papers/zotero/")
;; BibTeX file exported from Zotero.
(setq bibtex-completion-bibliography "/home/jihuan/文档/Documents/academic/Papers/zotero/zotero-library.bib")
;; Folder for storing PDF files, which I set it to the root folder of Zotero
;; library.
(setq bibtex-completion-library-path "/home/jihuan/文档/Documents/academic/Papers/zotero/")
;; Centralized note file.
(setq bibtex-completion-notes-path "/home/jihuan/文档/Documents/academic/Papers/zotero/notes.org")
;; The name of the BibTeX field in which the path to PDF files is stored or
;; ‘nil’ if no such field should be used.
(setq bibtex-completion-pdf-field "file")

;; Open pdf with system PDF viewer.
(setq bibtex-completion-pdf-open-function
      (lambda (fpath)
        (start-process "xdg-open" "*xdg-open*" "xdg-open" fpath)))
```

For citing a bibliography item from the database, call the command `org-ref-insert-cite-link`. If we click on the inserted link, an interactive buffer will be opened, from which we can choose to open the PDF file, BibTeX item or related notes.

![img](/figures/2022-07-24_14-47-44-org-ref-open-citation.png "Interaction with org-ref in Emacs Org mode")

Moreover, because some of my PDF files are associated with their bibliography items in the Zotero library as relative links (relative to a root path, which is stored in the variable `zotero-base-library`) instead of being imported as copies, the function `bibtex-completion-find-pdf-in-field` should be modified as below and evaluated after loading the `bibtex-completion` package. Otherwise, the path to any of these **linked** PDF files that is returned from the default version will be merely a single `/` character, which is invalid.

```elisp
(eval-after-load "bibtex-completion"
  '(defun bibtex-completion-find-pdf-in-field (key-or-entry)
     "Return the path of the PDF specified in the field `bibtex-completion-pdf-field' if that file exists.
Returns nil if no file is specified, or if the specified file
does not exist, or if `bibtex-completion-pdf-field' is nil."
     (when bibtex-completion-pdf-field
       (let* ((entry (if (stringp key-or-entry)
                         (bibtex-completion-get-entry1 key-or-entry t)
                       key-or-entry))
              (value (bibtex-completion-get-value bibtex-completion-pdf-field entry)))
         (cond
          ((not value) nil)         ; Field not defined.
          ((f-file? value) (list value))   ; A bare full path was found.
          ((-any 'f-file? (--map (f-join it (f-filename value)) (-flatten bibtex-completion-library-path))) (-filter 'f-file? (--map (f-join it (f-filename value)) (-flatten bibtex-completion-library-path))))
          (t                               ; Zotero/Mendeley/JabRef/Calibre format:
           (let ((value (replace-regexp-in-string "\\([^\\]\\)[;,]" "\\1\^^" value)))
             (cl-loop  ; Looping over the files:
              for record in (s-split "\^^" value)
                                        ; Replace unescaped colons by field separator:
              for record = (replace-regexp-in-string "\\([^\\]\\|^\\):" "\\1\^_" record)
                                        ; Unescape stuff:
              for record = (replace-regexp-in-string "\\\\\\(.\\)" "\\1" record)
                                        ; Now we can safely split:
              for record = (s-split "\^_" record)
              for file-name = (nth 0 record)
              for path = (or (nth 1 record) "")
              for paths = (if (s-match "^[A-Z]:" path)
                              (list path)                 ; Absolute Windows path
                                        ; Something else:
                            (append
                             (list
                              path
                              file-name
                              ;; (f-join (f-root) path) ; Mendeley #105
                              ;; (f-join (f-root) path file-name) ; Mendeley #105
                              (if (string-match-p "^\\.\\./" file-name)
                                  ;; If the ~file-name~ starts with
                                  ;; "../", it is a relative hyperlink to
                                  ;; the attachment, which has been
                                  ;; created in Zotero. The base
                                  ;; directory to which this relative
                                  ;; hyperlink is with respect is stored
                                  ;; in the variable
                                  ;; ~zotero-base-directory-for-linked-pdf~.
				                  (expand-file-name file-name zotero-base-directory-for-linked-pdf)
                                (f-join bibtex-completion-library-path file-name)))
                             (--map (f-join it path)
                                    (-flatten bibtex-completion-library-path)) ; Jabref #100
                             (--map (f-join it path file-name)
                                    (-flatten bibtex-completion-library-path)))) ; Jabref #100
              for result = (-first (lambda (path)
                                     (if (and (not (s-blank-str? path))
                                              (f-exists? path))
                                         path nil)) paths)
              if result collect result))))))))
```

Meanwhile, the variable `bibtex-completion-pdf-open-function` should be set as below. By default, it will use `xdg-open` to open the PDF file associated with a bibliography item. However, this does not work on my side, so I use `Okular` instead.

```elisp
;; Open pdf with Okular. xdg-open does not work here.
(setq bibtex-completion-pdf-open-function
  (lambda (fpath)
    (start-process "okular" "*okular*" "okular" fpath)))
```

{{ "2022-08-06-visiting-pdf-files-in-zotero-library-from-emacs-org-mode" | backlink }}
