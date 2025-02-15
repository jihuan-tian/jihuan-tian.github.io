---
layout: post
title: Keep home network reachable for remote working
date: 2025-02-15
categories: [computer]
tags: [network]
mathjax: false
---

I&rsquo;m using China Telecom&rsquo;s network with dynamic IP, through which I can provide my family several services, such as WebDAV based Joplin note system, music library that can be accessed from the Foobar music player on iOS, HTTPS based Calibre Ebooks, etc. However, the network is unstable due to three factors:

1.  If the fiber optical modem keeps on working without being shut down for more than one week, it tends to freeze sporadically.
2.  Sometimes, especially in the early morning around 4 or 5 am, the public IP for my home is lost and the modem does not try to acquire a new one.
3.  The dynamic IP will also change irregularly, which requires to change the dynamic DNS configuration.

Therefore, I&rsquo;ve created a bash script and scheduled its execution in crontab on my home Debian server. It periodically checks if the public network is reachable by pinging a web server:

```text
ping -c 3 -w 3 www.baidu.com > /dev/null 2>&1
```

If there is no error, I&rsquo;ll use `curl -s ifconfig.me` to get the current public IP and compare it with the old one. If the IP has changed, I&rsquo;ll reconnect VPN and update this new public IP to the dynamic DNS configuration.

If `www.baidu.com` is not reachable, I can use `python-miio` to switch off then turn on my Xiaomi smart WIFI plug which powers the modem. The model type of this plug is `cuco.plug.v3`, which should be controlled via the `genericmiot` command provided by `python-miio`. This solution is much easier than Home Assistant, without bothering to install a new operating system. In case there might be unexpected frequent plug switching, I&rsquo;ll only enable this operation when I travel outside.

**Installation and usage of `python-miio`**

-   Install the Git version of `python-miio` instead of the default one.
    
    ```text
    pip install git+https://github.com/rytilahti/python-miio.git
    ```
-   Execute the command `miiocli cloud`, then type in the user name and password registered for Xiaomi APP. From the output, we will get the token and MAC address of the plug.
-   Bind the MAC address with a fixed IP in the WIFI router.
-   Get the plug device status:
    
    ```text
    miiocli genericmiot --ip <IP> --token <token> status
    ```
-   List available actions provided by the plug:
    
    ```text
    miiocli genericmiot --ip <IP> --token <token> actions
    ```
    
    Only one action `toggle` is supported.
-   Execute an action:
    
    ```text
    miiocli genericmiot --ip <IP> --token <token> call <action-name>
    ```
-   Set on/off of the plug:
    
    ```text
    miiocli genericmiot --ip <IP> --token <token> set switch_on_2_1 True|False
    ```
    
    `switch_on_2_1` is the property name.

{{ "2025-02-15-keep-home-network-reachable-for-remote-working" | backlink }}
