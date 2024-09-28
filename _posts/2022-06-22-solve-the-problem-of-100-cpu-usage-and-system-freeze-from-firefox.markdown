---
layout: post
title: Solve the problem of 100% CPU usage and system freeze from Firefox
date: 2022-06-22
categories: [computer]
tags: [Firefox]
mathjax: false
---

I&rsquo;ve been suffering from the notorious problem of 100% CPU usage and adventitious window freeze or even the whole system collapse from Mozilla Firefox for a long time. The detailed phenomenon is that a process named &ldquo;Web Content&rdquo; fully occupies the CPU and there are also error messages in the console as below.

    nouveau: kernel rejected pushbuf: Invalid argument
    nouveau: ch18: krec 0 pushes 1 bufs 10 relocs 0
    nouveau: ch18: buf 00000000 00000015 00000002 00000002 00000000
    nouveau: ch18: buf 00000001 00000007 00000002 00000002 00000000
    nouveau: ch18: buf 00000002 0000000a 00000002 00000002 00000000
    nouveau: ch18: buf 00000003 0000000b 00000002 00000002 00000000
    nouveau: ch18: buf 00000004 00000008 00000002 00000002 00000000
    nouveau: ch18: buf 00000005 00000006 00000004 00000000 00000004
    nouveau: ch18: buf 00000006 0000001e 00000002 00000000 00000002
    nouveau: ch18: buf 00000007 00000020 00000002 00000000 00000002
    nouveau: ch18: buf 00000008 00000024 00000002 00000000 00000002
    nouveau: ch18: buf 00000009 00000030 00000002 00000000 00000002
    nouveau: ch18: psh 00000032 000007715c 0000077d68

Initially, I thought this might be caused by Firefox&rsquo;s own multi-threading mechanism. So I tried to limit the number of processes used by Firefox, but it did not work.

![](/figures/2022-06-22_09-13-29-limit-firefox-processes.png "Limit the number of processes used by Firefox")

Another guess on the cause of the problem might be related to the open source display driver `nouveau`. After some search, I came to this [bug report](https://bugs.webkit.org/show_bug.cgi?id=200437), which suggests to set the environment variable `WEBKIT_DISABLE_COMPOSITING_MODE=1`. According to the [documentation of WebKit](https://trac.webkit.org/wiki/EnvironmentVariables), this option forces the accelerated compositing mode adopted by `WebKitGTK` to be always off. And this just solves my problem.

{{ "2022-06-22-solve-the-problem-of-100-cpu-usage-and-system-freeze-from-firefox" | backlink }}
