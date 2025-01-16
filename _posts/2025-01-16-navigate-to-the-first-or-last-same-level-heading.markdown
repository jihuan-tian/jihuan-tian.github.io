---
layout: post
title: Navigate to the first or last same level heading
date: 2025-01-16
categories: [computer]
tags: [Emacs,Org-mode]
mathjax: false
---

I use Org mode and Org Roam to realize the concept of Zettelkasten note system. Usually, a new note belonging to some topic or category will be appended to other notes at the same heading level. As days pass by, the notes accumulate and those lists of same level headings may be very long, which is inconvenient to navigate.

I wrote the following two Elisp functions to help me quickly go to the first and last same level heading.

```elisp
(defun tjh/org-first-same-level-heading ()
  "Move to the first heading at the same level in the current Org buffer."
  (interactive)
  (let* ((current-line-number (line-number-at-pos))
         (previous-line-number -1))
    ;; Ensure we are not before the first heading.
    (if (org-current-level)
        (while (not (= current-line-number previous-line-number))
          ;; If the current line number is different from previous one, it means
          ;; previous movement is effective. Otherwise, it means we've already
          ;; reached the last subheading.
          (org-backward-heading-same-level 1)
          (setq previous-line-number current-line-number)
          (setq current-line-number (line-number-at-pos))))
    (message "You're already before any headings, do nothing!")))

(defun tjh/org-last-same-level-heading ()
  "Move to the last heading at the same level in the current Org buffer."
  (interactive)
  (let* ((current-line-number (line-number-at-pos))
         (previous-line-number -1))
    ;; Ensure we are not before the first heading.
    (if (org-current-level)
        (while (not (= current-line-number previous-line-number))
          ;; If the current line number is different from previous one, it means
          ;; previous movement is effective. Otherwise, it means we've already
          ;; reached the last subheading.
          (org-forward-heading-same-level 1)
          (setq previous-line-number current-line-number)
          (setq current-line-number (line-number-at-pos)))
      (message "You're already before any headings, do nothing!"))))
```

{{ "2025-01-16-navigate-to-the-first-or-last-same-level-heading" | backlink }}
