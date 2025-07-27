---
layout: post
title: Emacs tips learned and practiced in 2025 Week 30
date: 2025-07-27
categories: [computer]
tags: [Emacs]
mathjax: false
---

-   Have made my function `tjh/org-roam-open-node-by-id` support opening an Org id, which corresponds to a task in one of my Org agenda files, but is not included in my Org Roam note system. With a given id, this function first tries to acquire an Org Roam node with `org-roam-node-from-id`. If a node is found, use `org-roam-node-visit` to jump to this node. If it cannot be found, `org-id-goto` will be used to navigate to an Org task. N.B. The file to which this Org task belongs should have been registered as an agenda file, i.e. in the list `org-agenda-files`.
    
    ```elisp
    (defun tjh/org-roam-open-node-by-id (id)
      "Open an Org Roam node id or a normal Org id"
      (interactive "sNode id:")
      (let ((node (org-roam-node-from-id id)))
        (if node (org-roam-node-visit node)
          (org-id-goto id))))
    ```
    
    Then I can connect my mindmap nodes with either an Org task or an Org Roam node by adding the `roam://<org-id-or-org-roam-id>` link as an attribute. In the same way, I can also link my Anki cards with Org task or Org Roam.
-   I use Joplin markdown note to grab web pages and capture flashing ideas using voice input when I am walking or travel outside, so I need to copy markdown text directly into Emacs Org. The following script do this job. It uses `gui-get-selection` to acquire the contents in the clipboard. Then a temporary buffer is created with `with-temp-bufer`. The clipboard contents will be inserted into this buffer and then be processed by `pandoc`. Finally, the postprocessed contents are collected by `buffer-string` and inserted into the current buffer.
    
    ```elisp
    (defun tjh/paste-markdown-to-org ()
      "Convert the markdown contents in the clipboard to Org format then paste into the current buffer."
      (interactive)
      (let ((md (gui-get-selection 'CLIPBOARD)))
        (when md
          (let ((org (with-temp-buffer
    		   (insert md)
    		   (call-process-region (point-min) (point-max) "pandoc" t t nil
    					"-f" "markdown" "-t" "org" "--wrap=none")
    		   (buffer-string))))
    	(insert org)))))
    ```

{{ "2025-07-27-emacs-tips-learned-and-practiced-in-2025-week-30" | backlink }}
