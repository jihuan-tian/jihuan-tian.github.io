---
layout: post
title: 使用iPad远程访问GNU/Linux桌面
date: 2020-02-20
categories: [computer]
tags: [iPad,Linux]
---

通过vncserver/viewer可以实现iPad远程访问GNU/Linux桌面。具体做法如下。

首先，在GNU/Linux主机上做如下操作：

1. 安装tightvncserver。

2. 执行`vncpasswd`设置客户端访问vnc服务器的密码。

3. 在iptables中开放端口5901、5902……，分别对应vncserver的桌面1、桌面2……。

```
-A INPUT -p tcp --dport 5901 -j ACCEPT
```

4. 起动tightvncserver，开启桌面1。由于我使用的是9.7英寸的iPad Pro，需要将桌面尺寸设为2048×1536。同时，颜色深度设为24位。

```
tightvncserver -geometry 2048x1536 -depth 24 :1
```

5. 在桌面1内启动需要在iPad上显示的程序。例如，

```
DISPLAY=:1; okular file.pdf &
```

接下来，iPad上做如下操作：

1. 安装VNC Viewer。

![](/figures/p69869820.jpg)

2. 进入VNC Viewer应用，设置Address为GNU/Linux主机的IP地址，并在末尾加上桌面编号:1。“Password”中填入之前在主机上执行`vncpasswd`后设置的密码`。`“Picture quality”选为“High”。

![](/figures/p69869821.jpg)

3. 连接服务器，就可以看到之前启动的应用了。iPad也就变成了GNU/Linux主机的一块扩展屏幕。当然，若在iPad上再安装Termius应用，则可以通过SSH远程连接到主机上，执行自己想要使用的软件。这就相当于在iPad上以远程桌面的方式使用GNU/Linux主机。

最后，若要终止vnc桌面环境，在GNU/Linux主机执行如下命令即可。

```
tightvncserver -kill :1
```

{{ 2020-02-20-使用iPad远程访问GNU-Linux桌面 | backlink }}
