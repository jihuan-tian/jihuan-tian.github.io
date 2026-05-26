---
layout: post
title: Navigation and movement in Emacs
date: 2026-05-26
categories: [computer]
tags: [Emacs]
mathjax: false
---

# General movement in a window

-   Next and previous line: `C-n`, `C-p`
-   Next and previous character: `C-f`, `C-b`
-   Next and previous word: `M-f` or `C-<left>`, `M-b` or `C-<right>`
-   Scroll up (向下翻页) and down (向上翻页) a screen in the current window: `C-v`, `M-v`
-   Scroll up and down a line in other window: `M-<next>` (`tjh/scroll-other-window`), `M-<prior>` (`tjh/scroll-other-window-down`)
    
    ```elisp
    ;; Scroll other window with fixed number of lines.
    (setq tjh/scroll-other-window-lines 1)
    
    (defun tjh/scroll-other-window ()
      (interactive)
      (scroll-other-window tjh/scroll-other-window-lines))
    
    (defun tjh/scroll-other-window-down ()
      (interactive)
      (scroll-other-window-down tjh/scroll-other-window-lines))
    ```
-   Scroll up and down a screen in other window: `M-s-<next>`, `M-s-<prior>`
-   Forward and backward a balanced expression: `C-M-f`, `C-M-b`
-   Mark a balanced expression: `C-M-<space>`
-   Balance the sizes of windows: `C-x +`
-   Swap two windows left/right, up/down: `tjh/swap-two-windows`
-   Swap the current window with the central window: `tjh/swap-with-center-window`
    
    ```elisp
    (defun tjh/get-center-window-horizontal ()
      "Get the center window among a set of horizontally distributed windows in the current frame"
      (let* ((windows (window-list))
             (indexed-window-left-edge-pos
              (cl-mapcar #'cons (cl-mapcar #'car (cl-mapcar #'window-body-edges windows)) (number-sequence 0 (1- (length windows)))))
             (sorted-indexed-window-left-edge-pos
              (sort indexed-window-left-edge-pos (lambda (a b) (< (car a) (car b)))))
             (center-window-index (cdr (nth (/ (length windows) 2) sorted-indexed-window-left-edge-pos))))
        (nth center-window-index windows)))
    
    (defun tjh/swap-window-buffers (win1 win2)
      "Swap the buffers associated with two windows."
      (let ((buffer1 (window-buffer win1))
            (buffer2 (window-buffer win2)))
        (set-window-buffer win1 (buffer-name buffer2))
        (set-window-buffer win2 (buffer-name buffer1))))
    
    (defun tjh/swap-with-center-window ()
      "Swap the current window with the window in the center (horizontal) of the frame."
      (interactive)
      (let* ((current-window (selected-window))
             (center-window (tjh/get-center-window-horizontal)))
        (unless (eq current-window center-window)
          (tjh/swap-window-buffers current-window center-window)
          (select-window center-window))))
    
    (defun tjh/swap-two-windows ()
      "Swap the current window and the other window."
      (interactive)
      (let* ((current-window (selected-window))
             (adjacent-window (next-window)))
        (unless (eq current-window adjacent-window)
          (tjh/swap-window-buffers current-window adjacent-window)
          (select-window adjacent-window))))
    ```
-   Previous and next window configuration: `C-c <left>`, `C-c <right>`
-   Move the cursor to left/right/up/down window: `s-<left>/<right>/<up>/<down>`

# Navigation and heading/item manipulation in Org mode

-   Go to a heading in the buffer: `C-F7`
-   Previous and next item: `C-c <up>`, `C-c <down>`
-   Move a heading/item with its contents up and down: `M-<up>`, `M-<down>`
-   Move a heading/item with its subtree/items up and down: `M-S-<up>`, `M-S-<down>`
-   Promote/demote a heading/item with its contents: `M-<left>/<right>`
-   Promote/demote a heading/item with its subtree/items: `M-S-<left>/<right>`
-   Create a new same level heading: `C-<return>`
-   Create a new same level TODO heading: `C-M-<return>`
-   Create a new same level item: `M-<return>`
-   Create a new same level TODO item: `M-S-<return>`
-   Show headings to a certain level in the whole document: `C-<n> S-tab`
-   Show subheadings to a certain level within the current heading: `C-<n> C-c tab`
-   Show the heading hierarchy in the minibuffer: `tjh/org-where-am-i`
    
    ```elisp
    (defun tjh/org-show-outline-path ()
      "Show Org heading levels in the minibuffer."
      (interactive)
      ;; Only run it when we are in the org-mode.
      (when (eq major-mode 'org-mode)
        (let (;; Concatenated string to be displayed in the minibuffer
              (outline-path-string "")
              ;; Heading level
              (level 1)
              ;; Face to be assigned to the heading text
              (face))
          ;; Iterate over each ancestor headline of the current headline.
          (dolist (heading (org-get-outline-path t t))
            ;; Get a face from a collection of faces for org mode heading levels.
            ;; N.B. The index used by nth starts from 0.
            (setq face (nth (1- level) org-level-faces))
            (setq outline-path-string
                  (concat outline-path-string
                          ;; Prefix the heading with <level> number of stars.
                          (propertize (make-string level ?🍄) 'face face)
                          " "
                          (propertize heading 'face face)
                          ;; Concatenate headings of different levels with newline,
                          ;; in case the string is to long to be filled in the
                          ;; minibuffer.
                          "\n"))
            (setq level (1+ level)))
          (message "%s" outline-path-string))))
    (defalias 'tjh/org-where-am-i #'tjh/org-show-outline-path)
    ```

{{ "2026-05-26-navigation-and-movement-in-emacs" | backlink }}
