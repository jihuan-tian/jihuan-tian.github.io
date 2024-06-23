---
layout: post
title: Open Jekyll post URL from markdown-mode in Emacs
date: 2024-06-23
categories: [computer]
tags: [Emacs,Jekyll]
mathjax: false
---

Even though a Jekyll blog article is written in the Markdown format on the whole, post URLs are in the Liquid grammar, which cannot be directly opened from `markdown-mode` in Emacs. Such a post URL looks like this:

```text
{% raw %}[Link text]({% post_url jekyll-markdown-file-name %}{% endraw %})
```

Therefore, I&rsquo;ve modified the Elisp function `markdown-link-url` provided by `markdown-mode` and postprocessed the extracted `url` string via regular expression replacement. Then the linked post can be directly opened in Emacs.

```elisp
;; Process url to Jekyll post, so that it can be directly opened in markdown
;; mode.
(eval-after-load "markdown-mode"
  '(progn
     (defun markdown-link-url ()
       "Return the URL part of the regular (non-wiki) link at point.
Works with both inline and reference style links, and with images.
If point is not at a link or the link reference is not defined
returns nil."
       (let* ((values (markdown-link-at-pos (point)))
              (text (nth 2 values))
              (url (replace-regexp-in-string
                    {% raw %}"{% +post_url +\\(.*?\\) +%}" "\\1.markdown"{% endraw %}
                    (nth 3 values)))
              (ref (nth 4 values)))
         (or url (and ref (car (markdown-reference-definition
                                (downcase (if (string= ref "") text ref))))))))))
```
