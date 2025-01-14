---
layout: post
title: Configure Chinese font in Emacs
date: 2025-01-14
categories: [computer]
tags: [Emacs]
mathjax: false
---

Several concepts in Emacs should be clarified first.

-   Fontset: a fontset is the collection of fonts that Emacs uses to display all scripts it supports.
    
    Emacs defines three fontsets: standard, startup and default fontsets. The default fontset is the default fallback of the other two.

-   Script: [Oxford Advanced Learner] n. a set of letters in which a language is written. Therefore, a font covers a single or several scripts or alphabets.
-   Character set: it is a set of letters in one or several scripts. It is in the sense of symbols and not related to the representation on computers. For a same character set, there may be several ways of encoding.
-   Character code: the binary representation of characters on computers. Therefore, a complete character code or any subset of it naturally implies a character set.
-   Font: it defines how to draw the characters within its supported scripts. These scripts are represented by some character code. We can use `fontforge` to check the encoding supported by a font file.
-   Face: short for typeface, which is a set of letters, numbers, etc. of a particular design, used in printing. it is the style Emacs uses to display some text. It is equivalent to a CSS style. Some faces defined by Emacs are `default`, `bold`, `bold-italic`, etc. Some faces defined by Org mode are `org-level-1`, `org-level-2`, `org-quote`, etc.

Then, we assign the font &ldquo;Noto Sans Mono&rdquo; with a height 130 in units of 1/10 point to the `default` face for all existing frames.

```elisp
(set-face-attribute 'default nil :font "Noto Sans Mono" :height 130)
```

In the default fontset of Emacs, we set the font for Chinese related scripts and character sets, so that English and Chinese can be displayed in different fonts.

```elisp
(dolist (script-or-charset '(han cjk-misc chinese-gbk kana big5 big5-hkscs chinese-big5-1 chinese-big5-2))
  (set-fontset-font t script-or-charset (font-spec :family "仓耳今楷05")))
```

Check the variable `script-representative-chars` for a list of scripts and execute `list-character-sets` to see a list of character sets. In the above configuration, `han`, `cjk-misc` and `kana` are scripts. `chinese-gbk`, `big5`, `big5-hkscs`, `chinese-big5-1` and `chinese-big5-2` are character sets.

The characters in big5 charset is like this.
![img](/figures/2025-01-14_09-47-05-emacs-character-sets.png)

Because the font 仓耳今楷05 is a bit smaller than a same size English font, we assign it a scaling factor.

```elisp
;; Use Chinese in the font name and the rescaling will take effect.
(add-to-list 'face-font-rescale-alist '("仓耳今楷05" . 1.3))
```

Now the Chinese font in Emacs editor looks more comfortable.
![img](/figures/2025-01-14_10-07-54-emacs-with-tsanger-font.png)

{{ "2025-01-14-configure-chinese-font-in-emacs" | backlink }}
