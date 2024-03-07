---
layout: post
title: Solved the issue of anki-editor not working
date: 2024-03-07
categories: [computer]
tags: [Emacs,Org-mode,Anki,bug]
mathjax: false
---

Environment

-   Anki version 2.1.49 (dc80804a), Python 3.8.1 Qt 5.15.1 PyQt 5.15.1
-   Newest version of AnkiConnect, installed via the plugin code `2055492159`


<a id="orgb418634"></a>

# Problem 1: Unable to start AnkiConnect

Phenomenon

```text
from anki.scheduler.base import ScheduleCardsAsNew ImportError: cannot import name 'ScheduleCardsAsNew' from 'anki.scheduler.base' (/usr/local/share/anki/scheduler/base.pyc)
```

Solution: Download Anki Connect version 23.10.29.0 and use its contents to replace those in the folder `~.local/share/Anki2/addons21/2055492159`.

Reference: <https://www.youtube.com/watch?v=vxNJzoueK9M>


<a id="org6cfb6c2"></a>

# Problem 2: Cannot run anki-editor

Phenomenon

```text
[error] request--curl-sync: semaphore never called
anki-editor--anki-connect-invoke: Wrong number of arguments: (3 . 3), 2
```

Cause: coding system error.

Solution: In the commit message of `084ffad14fa700ad1ba95d8cbfe4a8f6052e2408` of `anki-editor`, the `request` package must be upgraded to 0.3.1. My previous version is `20211107.1907`, which produces the above error.

Reference: <https://github.com/louietan/anki-editor/issues/51#issuecomment-533876400>
