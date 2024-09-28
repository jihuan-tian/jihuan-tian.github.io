---
layout: post
title: Display LaTeX math equations in source code comment in Emacs
date: 2024-05-16
categories: [computer]
tags: [Emacs,LaTeX]
mathjax: false
---

Define a string filter function to remove the leading comment symbols. Then LaTeX equations written in the Doxygen format can be rendered in Emacs by the `texfrag` extension.

```elisp
(defun texfrag-cpp-filter (str)
  "`texfrag-cpp-filter' filtering STR for C++ programming"
  (setq str (replace-regexp-in-string 
             "^ *\\(/\\* *\\)\\|\\(\\* *\\)\\|\\(// *\\)" 
             "" str)))

(defun texfrag-octave-filter (str)
  "`texfrag-octave-filter' filtering STR for Octave programming"
  (setq str (replace-regexp-in-string "^ *#+" "" str)))

(defun tjh/texfrag-cpp ()
  (interactive)
  (setq texfrag-equation-filter #'texfrag-cpp-filter))

(defun tjh/texfrag-octave ()
  (interactive)
  (setq texfrag-equation-filter #'texfrag-octave-filter))

(defun tjh/texfrag-default()
  (interactive)
  (setq texfrag-equation-filter #'identity))
```

![img](/figures/2024-05-16_13-24-21-texfrag-for-programming@emacs.png)

{{ "2024-05-16-display-latex-math-equations-in-source-code-comment-in-emacs" | backlink }}
