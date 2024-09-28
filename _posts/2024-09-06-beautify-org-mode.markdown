---
layout: post
title: Beautify Org mode
date: 2024-09-06
categories: [computer]
tags: [Emacs, Org-mode]
mathjax: false
---

To make my Org mode visually appealing, I&rsquo;ve done the following steps.

-   Customize faces for different Org headings and emphasis. For example,
    
    ```elisp
    (custom-set-faces
     '(org-agenda-structure ((t (:foreground "deep sky blue"))))
     '(org-block ((t (:inherit shadow :extend t :background "beige" :foreground "dark slate gray"))))
     '(org-code ((t (:background "light cyan" :foreground "dark cyan"))))
     '(org-date ((t (:background "thistle1" :foreground "Purple" :underline t))))
     '(org-drawer ((t (:foreground "deep sky blue"))))
     '(org-footnote ((t (:foreground "medium sea green" :underline t :height 0.9))))
     '(org-level-1 ((t (:inherit outline-1 :extend nil :height 1.3))))
     '(org-level-2 ((t (:inherit outline-2 :extend nil :height 1.2))))
     '(org-level-3 ((t (:inherit outline-3 :extend nil :height 1.1))))
     '(org-level-4 ((t (:inherit outline-4 :extend nil))))
     '(org-meta-line ((t (:inherit font-lock-comment-face :height 0.8))))
     '(org-quote ((t (:inherit org-block :background "beige" :foreground "dark green" :height 1.4 :family "EB Garamond"))))
     '(org-ref-cite-face ((t (:inherit org-link :background "DarkSeaGreen1" :foreground "forest green" :box (:line-width 2 :color "grey75" :style released-button)))))
     '(org-scheduled-previously ((t (:foreground "dark violet"))))
     '(org-tag ((t (:background "khaki" :foreground "dark green" :weight bold :family "EB Garamond"))))
     '(org-todo ((t (:background "#fdf6e3" :foreground "#dc322f" :inverse-video nil :underline nil :slant normal :weight bold))))
     '(org-verbatim ((t (:inherit (shadow org-code))))))
    ```
-   Use my favorite KaiTi for Chinese and EB Garamond for English in Org quote and verse blocks.
    
    ```elisp
    ;; Create a new fontset for org block and verse.
    (create-fontset-from-fontset-spec
     (font-xlfd-name
      (font-spec :family "courier"
                 :registry "fontset-org quote")))
    
    (dolist (charset '(han cjk-misc chinese-gbk kana))
      (set-fontset-font "fontset-org quote" charset (font-spec :family "KaiTi")))
    (dolist (charset '(big5 big5-hkscs chinese-big5-1 chinese-big5-2))
      (set-fontset-font "fontset-org quote" charset (font-spec :family "AR PL UKai TW")))
    (set-fontset-font "fontset-org quote" 'ascii
                      (font-spec :family "EB Garamond"))
    
    ;; Enable fontification of quote and verse blocks.
    (setq org-fontify-quote-and-verse-blocks 
    (set-face-attribute 'org-quote nil :fontset "fontset-org quote")
    ```
-   Enable `org-indent-mode` to add visual indentation to different levels of headings and contents. Also remember to set `org-adapt-indentation` as `nil`. Otherwise, besides the visual indentation, actual indentation in the text is still there, and when there are many levels, the effective width of a paragraph will be very narrow. When the paragraph contains many LaTeX equations to be rendered (via `texfrag` for example), they will be scattered into several lines, which is difficult to read.
-   `org-modern-mode` looks great but is incompatible with `org-indent-mode` in that the visual indentation of a whole source code block will become zero, if two modes are enabled at the same time. Therefore, I do not use `org-modern-mode` anymore.
-   Enable `org-visual-indent-mode` to add vertical lines which connect headings on a same level.

The final effect of my Org mode is as below.

![img](/figures/2024-09-06_10-40-54-beautify-org-mode.png)

{{ "2024-09-06-beautify-org-mode" | backlink }}
