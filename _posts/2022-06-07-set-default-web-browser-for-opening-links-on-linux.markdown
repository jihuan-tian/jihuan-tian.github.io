---
layout: post
title: Set default web browser for opening links on Linux
date: 2022-06-07
categories: [computer]
tags: [Linux]
mathjax: false
---

Days ago, I downloaded and installed Firefox of the newest version. I also set it as the default application for opening HTML documents and URL links. After I uninstalled it and restored the default version shipped with Debian Buster, even though I updated the configuration for default web browser, when I opened a URL link from within a PDF document, it still tries to run the old Firefox.

In `System Settings` → `Personalization` → `Applications` → `Default Applications` → `Web Browser`, check the `in the following application` then switch back to the default `in an application based on the contents of the URL`. The above problem is solved.

![img](/figures/2022-06-07_11-57-34-reset-default-browser-in-system-setting.png)

{{ "2022-06-07-set-default-web-browser-for-opening-links-on-linux" | backlink }}
