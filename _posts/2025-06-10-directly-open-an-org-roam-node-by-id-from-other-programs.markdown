---
layout: post
title: Directly open an Org roam node by id from other programs
date: 2025-06-10
categories: [computer]
tags: [Org-roam]
mathjax: false
---

Since I want to interconnect Org Roam notes with my Anki cards and Freeplane mindmaps, I need to create a customized link type like this `roam://<org-roam-node-id>`, which can be directly opened from other programs.

1.  Create an Elisp function for opening the Org Roam node by id:
    
    ```elisp
    (defun tjh/org-roam-open-node-by-id (id)
      (interactive "sNode id:")
      (let ((node (org-roam-node-from-id id)))
        (if node (org-roam-node-visit node))))
    ```

2.  Create a Bash script `open-org-roam-node-link.sh`, which uses `emacsclient` to evaluate the elisp code to open the node:
    
    ```bash
    #!/bin/bash
    emacsclient --eval "(let ((node (org-roam-node-from-id (substring \"$1\" 7 nil)))) (if node (org-roam-node-visit node) (message \"Node not found!\")))"
    ```

3.  Create a new `desktop` file `~/.local/share/applications/roam-url-handler.desktop`:
    
    ```text
    [Desktop Entry]
    Name=Roam URL Handler
    Exec=/usr/local/bin/scripts/open-org-roam-node-link.sh %u
    Terminal=false
    Type=Application
    NoDisplay=true
    MimeType=x-scheme-handler/roam;
    ```

4.  Register the above `desktop` file:
    
    ```text
    xdg-mime default roam-url-handler.desktop x-scheme-handler/roam
    ```

5.  Insert `roam://<org-roam-node-id>` links in other programs, such as Anki:
    
    ![img](/figures/2025-06-03_11-56-55-anki-card-with-org-roam-node-link.png)
    
    ![img](/figures/2025-06-03_11-56-00-anki-card-with-org-roam-node-link.png)

{{ "2025-06-10-directly-open-an-org-roam-node-by-id-from-other-programs" | backlink }}
