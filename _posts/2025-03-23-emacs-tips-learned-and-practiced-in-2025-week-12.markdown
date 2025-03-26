---
layout: post
title: Emacs tips learned and practiced in 2025 Week 12
date: 2025-03-23
categories: [computer]
tags: [Emacs]
mathjax: false
---

-   Frequent switching between different buffers is inconvenient, so I&rsquo;ve started to use multiple frames to maintain different working scenarios, such as taking work journal, programming in C++, navigating folders in Dired mode, processing data with Julia.
-   To prevent sporadic lag or delay while I key in characters within Emacs, I restrict the maximum font-lock level for Org mode.
    
    ```elisp
    (setq font-lock-maximum-decoration '((org-mode . 1) (t . t)))
    ```
-   Directly change the background color of a linked image in Org mode or edit it in Krita. This is very useful for integrating my scanned notes and sketches into Org Roam.
    
    ```elisp
    (defun tjh/org-open-link-with-named-app (app)
      "Open the Org link at point with the given app."
      (let* ((link (org-element-property :path (org-element-context))))
        (start-process-shell-command "org-open-link" nil (format "%s '%s'" app link))))
    
    (defun tjh/org-edit-image-with-krita ()
      "Edit a linked handwriting image using Krita."
      (interactive)
      (tjh/org-open-link-with-named-app "krita"))
    
    (defun tjh/solarize-scanning ()
      "Edit a linked handwriting image using Krita."
      (interactive)
      (tjh/org-open-link-with-named-app "solarize-scanning.sh"))
    ```

{{ "2025-03-23-emacs-tips-learned-and-practiced-in-2025-week-12" | backlink }}
