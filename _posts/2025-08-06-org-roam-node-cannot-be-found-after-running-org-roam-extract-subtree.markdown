---
layout: post
title: Org roam node cannot be found after running org-roam-extract-subtree
date: 2025-09-15
categories: [computer]
tags: [Emacs,Org-roam]
mathjax: false
---

**Phenomenon**

-   A heading with its contents in an Org file is already an Org roam node, but it is placed with other notes and not an independent file.
-   Execute `org-roam-extract-subtree` to move this heading and its contents to a new Org file. Its node `ID` is intact.
-   After saving the new Org file and execute `org-roam-db-sync`, this roam node cannot be found.

**Possible Cause**

Initially, I thought the error may come from my own property `CREATED`, which holds a timestamp. However, this is not the cause.

**Solution**

Remove all node properties except `ID` and keep an empty line between the property drawer and the title line. Then refresh the database and this independent node will be included in the database, which can be verified by executing `org-roam-db-diagnose-node`. Finally, paste other properties back, if there are any.

{{ "2025-08-06-org-roam-node-cannot-be-found-after-running-org-roam-extract-subtree" | backlink }}
