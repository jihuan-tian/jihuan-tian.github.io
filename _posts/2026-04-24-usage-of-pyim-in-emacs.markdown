---
layout: post
title: Usage of pyim in Emacs
date: 2026-04-24
categories: [computer]
tags: [emacs]
mathjax: false
---

-   To reduce tension on finger muscles, now I use `pyim-wbdict-v86-enable` instead of `pyim-wbdict-v86-single-enable`.
-   pyim uses the function `pyim-candidates-xingma-words-default` to order characters and words for selection.
    
    ```elisp
    (defun pyim-candidates-xingma-words-default (code)
      "搜索形码 CODE, 得到相应的词条列表。
    
    当前的词条的构建规则是：
    1. 先排公共词库中的字。
    2. 然后再排所有词库中的词，词会按词频动态调整。"
      (let* ((common-words (pyim-dcache-get code '(code2word)))
             (common-chars (pyim-candidates--get-chars common-words))
             (personal-words (pyim-dcache-get code '(icode2word)))
             (other-words (pyim-dcache-get code '(shortcode2word)))
             (words-without-chars
              (pyim-candidates--sort
               (pyim-candidates--remove-chars
                (delete-dups
                 `(,@personal-words
                   ,@common-words
                   ,@other-words))))))
        `(,@common-chars
          ,@words-without-chars)))
    ```
    
    The finally returned list of this function is a combination of `common-chars` and `words-without-chars`, i.e. **characters are placed before words.**
    
    At the moment, wubi 86 provided by pyim uses large character set, so uncommon characters will appear before common words.
-   pyim uses `pyim-toggle-assistant-scheme` to change to a temporary input method, which is configured in the variable `pyim-assistant-scheme`. This mechanism is useful when we forget the wubi code for a character and want to consult it via the pinyin input method.
    
    ```elisp
    (defun pyim-toggle-assistant-scheme ()
      "临时切换到辅助输入法.
    
    这个功能一般用于五笔等形码输入法，在忘记编码的时候临时用拼音输入
    中文。"
      (interactive)
      (if (pyim-process-without-entered-p)
          (pyim-process-select-last-char)
        (pyim-scheme-toggle-assistant)
        (pyim-process-run)))
    ```
    
    In this function, when there is no characters entered in pyim, `pyim-process-without-entered-p` will return true and `pyim-process-select-last-char` will be executed and the input method will not be toggled. This means if we want to search the wubi code of a character, we must first type some part or the whole pinyin of the character, then press `TAB` to trigger `pyim-toggle-assistant-scheme`.
-   The page length of pyim (`pyim-page-length`) should not be too short, because uncommon characters appear before common words. Otherwise, those common words are invisible and cannot be selected.
-   Enable `pyim-dcache-auto-update` to make let pyim automatically adjust the word order according to their usage frequency.

The whole configuration for pyim is below.

```elisp
(require 'pyim)
(require 'pyim-wbdict)
(setq default-input-method "pyim")
(global-set-key (kbd "M-\\") #'toggle-input-method)
(pyim-default-scheme 'wubi)
(pyim-wbdict-v86-enable)
;; Use fullwidth punctuations.
(setq-default pyim-punctuation-translate-p '(auto))
;; Disable popup tooltip, use the minibuffer instead, which greatly reduce
;; screen flashes.
(setq pyim-page-tooltip 'minibuffer)
(setq pyim-assistant-scheme 'quanpin)
;; Disable word detection from the current buffer and word thinking to improve
;; performance.
(setq pyim-candidates-search-buffer-p nil)
(setq pyim-enable-shortcode nil)
;; Keep 6 options in the selection page.
(setq pyim-page-length 6)
;; When using non-single char input, enable automatic adjusting word order
;; depending on its usage frequency.
(setq pyim-dcache-auto-update t)
```

{{ "2026-04-24-usage-of-pyim-in-emacs" | backlink }}
