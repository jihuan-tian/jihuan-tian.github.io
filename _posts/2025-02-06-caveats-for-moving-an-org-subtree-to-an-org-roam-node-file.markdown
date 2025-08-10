---
layout: post
title: Caveats for moving an Org subtree to an org-roam node file
date: 2025-02-17
categories: [computer]
tags: [Emacs,Org-roam,Org-mode]
mathjax: false
---

When an Org file containing org-roam notes is too large, it is necessary to move a subtree to an independent org-roam node file via the command `org-roam-extract-subtree`.

**Caveats**

1.  The node file must start with `:PROPERTIES:`, otherwise, it cannot be considered as an org-roam note. Then if the subtree has a timestamp such as `CLOSED`, this timestamp will appear on the first line, which invalidates the node file. Therefore, it should be manually removed.
2.  There should be no `CREATED: <time-stamp>` property that I&rsquo;ve used, otherwise only the node ID is in the org-roam database but nothing else. This can be verified by running `org-roam-db-diagnose-node` in the node file buffer and we only obtain something like this:
    
    ```text
    #s(org-roam-node nil nil nil nil nil "80166ed4-1374-4bca-a647-6e0058b77717" nil 129 nil nil nil nil nil nil nil nil nil nil)
    ```
    
    After deleting the `CREATED` property and updating the database, the diagnosis returns meaningful results.
    
    ```text
    #s(org-roam-node "/home/jihuan/文档/Documents/peabody/docs/org-notes/20241115180500-operator_preconditioning_in_bem.org" "Operator preconditioning in BEM" nil (26546 47291 830650 561000) (26546 47289 774607 292000) "80166ed4-1374-4bca-a647-6e0058b77717" 0 1 nil nil nil nil "Operator preconditioning in BEM" (("CATEGORY" . "20241115180500-operator_preconditioning_in_bem") ("ID" . "80166ed4-1374-4bca-a647-6e0058b77717") ("CREATED" . "<2024-11-15 Fri 18:05>") ("BLOCKED" . "") ("FILE" . "/home/jihuan/文档/Documents/peabody/docs/org-notes/20241115180500-operator_preconditioning_in_bem.org") ("PRIORITY" . "B")) nil nil nil nil)
    ```
    
    The cause is probably that the Org timestamp contains the special characters `<` and `>`, which need to be escaped. Solution: simply wrap the timestamp with double quotes.

{{ "2025-02-06-caveats-for-moving-an-org-subtree-to-an-org-roam-node-file" | backlink }}
