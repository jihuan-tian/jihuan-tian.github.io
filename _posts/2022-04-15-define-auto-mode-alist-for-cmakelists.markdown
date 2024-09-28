---
layout: post
title: Define auto-mode-alist for CMakeLists.txt
date: 2022-04-15
categories: [computer]
tags: [Emacs,CMake]
mathjax: false
---

According to [here](https://www.emacswiki.org/emacs/AutoModeAlist), `\'` matches the end of a string, while `$` matches the empty string before a newline. Thus, `$` may lead to unexpected behavior when dealing with filenames containing newlines.

Therefore, `auto-mode-alist` should be configured like this:

```lisp
(add-to-list 'auto-mode-alist '("\\.xml\\'".  sgml-mode))
```

The association of `cmake-mode` to `CMakeLists.txt` has already been defined during the loading of the package `cmake-mode`. Since this package was installed via `list-packages`, it has been added to the list variable `package-selected-packages` in `custom-set-variables` as below.

```lisp
(custom-set-variables
  '(package-selected-packages
   (quote
    (... cmake-font-lock cmake-ide cmake-mode cmake-project ...))))
```

Therefore, by checking the value of `auto-mode-alist`, we can see this item:

```lisp
("CMakeLists\\.txt\\'" . cmake-mode)
```

Because those variables configured by `custom-set-variables` take effect before the executation of any lines of code in `~/.emacs`, to prevent the association of the `text-mode` to `*.txt` files from taking priority over the configuration for `CMakeLists.txt` in `auto-mode-alist`, we need to append further "major mode-file type" association items to the end of `auto-mode-alist`. That's why the fourth argument of `add-to-list` as below is set to `t`.

```lisp
(mapcar
 (function (lambda (setting)
	     (add-to-list 'auto-mode-alist setting t)))
 '(("\\.xml\\'".  sgml-mode)
   ("\\.bash\\'" . sh-mode)
   ("\\.rdf\\'".  sgml-mode)
   ("\\.session\\'" . emacs-lisp-mode)
   ("\\.h\\'" . c++-mode)
   ("\\.l\\'" . c-mode)
   ("\\.css\\'" . css-mode)
   ("\\.org\\'" . org-mode)
   ("\\.cfm\\'" . html-mode)
   ("gnus" . emacs-lisp-mode)
   ("\\.gpl\\'" . gnuplot-mode)
   ("\\.txt\\'" . text-mode)
   ("\\.idl\\'" . idl-mode)
   ("\\.m\\'" . octave-mode)
   ("\\.scm\\'" . scheme-mode)
   ("\\.mod\\'" . rapid-mode)
   ("\\.bas\\'" . visual-basic-mode)
   ("\\.ino\\'" . c++-mode)
   ("\\.max\\'" . maxima-mode)
   ("\\.mac\\'" . maxima-mode)
   ("\\.dem\\'" . maxima-mode)
   ("configure\\.in\\'" . m4-mode)
   ("\\.m4\\'" . m4-mode)
   ("\\.proto\\'" . protobuf-mode)))
```

{{ "2022-04-15-define-auto-mode-alist-for-cmakelists" | backlink }}
