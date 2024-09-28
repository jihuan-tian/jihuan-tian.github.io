---
layout: post
title: Install software from official websites instead of Linux release
date: 2022-04-05
categories: [computer]
tags: [Linux,Firefox]
mathjax: false
---

The default firefox-esr version 91.7.0 on Debian GNU/Linux 10 (buster) often crashes accidentally, especially when I’m watching online videos or visiting web pages containing a lot of images. Moreover, Firefox may periodically gets stuck and occupies 100% of the CPU resource, which will further cause the X11 Window system to freeze with the only exception that the mouse pointer is still movable. Even though I can remotely login via SSH and kill the process for Firefox, there will be no more response from the X11 Windows system anymore and the Linux system can neither be shut down nor rebooted. The final rescue is to press the reboot button on the power case.

Today, I manually downloaded and installed the newest Firefox version 98.0.2 from Mozilla’s official website. To migrate my previous configurations, customizations and installed extensions in Firefox, I visited the address `about:profiles` in Firefox, where all the user profiles stored under the folder `~/.mozilla/firefox/` were listed. Then I selected my old profile and restarted the browser. Except that the `SwitchyOmega` extension did not function properly and needed a reinstallation, everything had been migrated smoothly.

We know that open source software packages evolute much faster than years before due to increased contributors and growing community. During this process, these software packages are gradually forming their own ecological systems, such as package management tool, mirror sites, source code hosting services. To name a few, there are Emacs with Elpa, TeX with CTAN, Python with pip, Ruby with gem, as well as lots of packages hosted on GitHub. Then it is easy to understand that the curation and incorporation of these software packages into the official Linux release cannot keep up with the pace of their updates. Therefore, I think we will install and update more and more software packages independently from their official websites or hosting mirrors instead of adopting the default and usually old and unstable versions distributed with the Linux release, even though the release is called *stable*. This phenomenon can be considered as a continuation of the trend from cathedral to bazaar.

{{ 2022-04-05-install-software-from-official-websites-instead-of-linux-release | backlink }}
