---
layout: post
title: org-roam-ui cannot visualize all nodes
date: 2024-11-02
categories: [computer]
tags: [Emacs,Org-roam,bug]
mathjax: false
---

Recently, when I started `org-roam-ui`, Firefox reported an error in a blank page:

```text
Application error: a client-side exception has occurred (see the browser console for more information).
```

At the beginning, I temporarily solved the problem by sifting out &ldquo;Orphan&rdquo; nodes. This manual operation must be quick enough before the above error appears.

![img](/figures/2024-09-12_12-10-24-enable-org-roam-ui-orphans-filter.png)

Or an easier way is to open the Firefox developer tool, then go to &ldquo;Storage → Local Storage → <http://localhost:35901>&rdquo;, and modify the value of the key `filter` as below.

![img](/figures/2024-09-22_10-10-51-org-roam-ui-filter-orphans.png)

To find the real cause of the above problem, today I cleaned the `org-roam` folder first, then added my Org files back one-by-one and finally found the culprit came from a file named `cpp.org`. But still, the exact error location was not known. Further, I deleted each note in this file one-by-one until I found out the problem was caused by a note with a tag `constructor`. Unfortunately, `constructor` is a special method of a Javascript class for creating and initializing an instance of that class. So `org-roam-ui` must have treated this note tag as a function to execute.

**Solution**

Do not add `constructor` tag to any `org-roam` note.

{{ "2024-11-02-org-roam-ui-cannot-visualize-all-nodes" | backlink }}
