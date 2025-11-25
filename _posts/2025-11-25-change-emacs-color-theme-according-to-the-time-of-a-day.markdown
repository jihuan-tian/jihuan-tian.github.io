---
layout: post
title: Change Emacs color theme according to the time of a day
date: 2025-11-25
categories: [computer]
tags: [Emacs]
mathjax: false
---

I&rsquo;ve defined the following functions to load different Emacs color themes. The two packages `solarized-theme` and `gruvbox-theme` should be installed. N.B. Before loading a new color theme, all previously loaded themes should be disabled.

```elisp
(defun tjh/load-day-color-theme ()
  "Color theme for a sunny daytime."
  (interactive)
  (mapc #'disable-theme custom-enabled-themes)
  ;; Don't change size of org-mode headlines (but keep other size-changes)
  (setq solarized-scale-org-headlines nil)
  ;; Don't change the font for some headings and titles
  (setq solarized-use-variable-pitch nil)
  (load-theme 'solarized-light t))

(defun tjh/load-eve-color-theme ()
  "Color theme for the evening."
  (interactive)
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme 'gruvbox-light-medium t))

(defun tjh/load-dimday-color-theme ()
  "Color theme for a cloudy daytime."
  (interactive)
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme 'gruvbox-light-hard t))
```

Then I can use `emacsclient` to enable these themes in Bash scripts. For example,

```bash
emacsclient -u --eval "(tjh/load-day-color-theme)"
```

The option `-u` suppresses the output of `emacsclient` returned to the console.

Then the Bash scripts can be scheduled at different times in a day in `crontab`.

```text
0 7 * * * /usr/local/bin/scripts/emc-dimday.sh
0 8 * * * /usr/local/bin/scripts/emc-day.sh
0 17 * * * /usr/local/bin/scripts/emc-dimday.sh
0 19 * * * /usr/local/bin/scripts/emc-eve.sh
```

{{ "2025-11-25-change-emacs-color-theme-according-to-the-time-of-a-day" | backlink }}
