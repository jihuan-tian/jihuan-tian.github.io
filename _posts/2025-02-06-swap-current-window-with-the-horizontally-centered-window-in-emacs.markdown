---
layout: post
title: Swap current window with the horizontally centered window in Emacs
date: 2025-02-06
categories: [computer]
tags: [Emacs]
mathjax: false
---

With a HighDPI monitor, I usually open three horizontal windows in a Emacs frame. I use the following scripts to focus on the current window by swapping it with the central window.

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
```

{{ "2025-02-06-swap-current-window-with-the-horizontally-centered-window-in-emacs" | backlink }}
