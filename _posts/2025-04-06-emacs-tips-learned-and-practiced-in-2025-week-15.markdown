---
layout: post
title: Emacs tips learned and practiced in 2025 Week 15
date: 2025-04-06
categories: [computer]
tags: [Emacs]
mathjax: false
---

-   Swap the buffers of two windows, which is very useful for side-by-side coding, e.g. the left window for reference and the right window for modification.
    
    ```elisp
    (defun tjh/swap-two-windows ()
      "Swap the current window and the other window."
      (interactive)
      (let* ((current-window (selected-window))
    	 (adjacent-window (next-window)))
        (unless (eq current-window adjacent-window)
          (tjh/swap-window-buffers current-window adjacent-window)
          (select-window adjacent-window))))
    ```
-   Swap two word using `transpose-words`, bound to `M-t`. For example, by placing the cursor between the two words, this converts
    
    ```c++
    H.prepare_for_vmult_or_tvmult(true, false);
    ```
    
    to
    
    ```c++
    H.prepare_for_vmult_or_tvmult(false, true);
    ```
-   Customized the colors adopted by the `tabbar` package to highlight the buffer status.
    -   Foreground color: <span style="color:#bfbfbf">gray75</span>
    -   Currently focused buffer (unmodified): <span style="background-color:#006400; color:#bfbfbf">dark green</span>
    -   Currently focused buffer (modified): <span style="background-color:#d2691e; color:#bfbfbf">chocolate</span>
    -   Non-focused buffer (unmodified): <span style="background-color:#7f7f7f; color:#bfbfbf">gray50</span>
    -   Non-focused buffer (modified): <span style="background-color:#8b4513; color:#bfbfbf">saddle brown</span>
    
    ```elisp
    (custom-set-faces
     '(tabbar-default ((t (:inherit variable-pitch :background "gray75" :foreground "gray50" :height 1.3 :family "Noto Sans CJK SC"))))
     '(tabbar-modified ((t (:inherit tabbar-default :foreground "saddle brown" :box (:line-width (1 . 1) :color "white" :style released-button)))))
     '(tabbar-selected ((t (:inherit tabbar-default :foreground "dark green" :box (:line-width (1 . 1) :color "white" :style pressed-button)))))
     '(tabbar-selected-modified ((t (:inherit tabbar-default :foreground "chocolate" :box (:line-width (1 . 1) :color "white" :style released-button))))))
    ```

{{ "2025-04-06-emacs-tips-learned-and-practiced-in-2025-week-15" | backlink }}
