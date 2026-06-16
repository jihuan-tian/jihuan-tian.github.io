---
layout: post
title: 基于 Emacs 的 C++ LSP 还不足以应对实际项目开发
date: 2026-06-14
categories: [computer]
tags: [emacs,LSP]
mathjax: false
slug: emacs-cpp-lsp-still-not-capable-of-project-development
---

前一段时间我尝试了 lsp-bridge 扩展包，最近又切换到 Emacs 自带的 LSP 客户端 eglot ，折腾了一圈发现还是没有办法完全使用 Emacs 编辑器来开发大规模的 C++ 语言软件项目。

例如，在使用 lsp-bridge 的过程中，很多时候代码跳转会失灵——当然也有可能是由于项目的大规模重构工作尚未完成，代码中仍存在许多错误与不一致，重构前生成的 `compile_commands.json` 文件中的内容与实际代码相去甚远；同时，初次开启 lsp-bridge breadcrumb 后 header line 显示为空白，必须要关闭 breadcrumb 后再打开才可以；编辑较大的文件时，存在明显的卡顿现象，严重影响正常的编码活动。

使用 eglot 时，存在更严重的问题：后台的 C++ 语言服务器 clangd 在持续运行中会产生大量临时文件 `*.pch` ，将磁盘空间完全用尽。默认情况下， clangd 会将这些文件写入 `/tmp` 。在 Debian Trixie 中，这是一个完全处于虚拟内存中的文件系统，空间大小为物理内存的一半——在我的电脑上则是 16 GB 。 clangd 启动后很快这个分区就被写满，代码索引暂停。通过修改环境变量 `TMPDIR` ，我让临时文件写入物理磁盘。结果 Emacs 经过一夜便将磁盘上剩余的 600 GB 全部用尽。奇怪的是，虽然之前的 lsp-bridge 也调用了 clangd ，但我未发觉有磁盘空间耗尽的情况。

此外，无论是使用 lsp-bridge 还是 clangd ，若针对同一个文件在 Emacs 中打开了多个窗口，当在一个窗口中编辑该文件时，光标会时不时地跳到另一个窗口的光标位置（仍在当前窗口内跳转）。在未启动 lsp-bridge 或 clangd 的情况下，则基本没有该问题。一个临时性的解决办法是使用 `clone-indirect-buffer` 使多个窗口中的光标位置相互独立。

幸好 VS Code 基于 cpptools 的 IntelliSense 代码分析可以设置最大的缓存空间用量。最终，我采用了 Emacs 编辑代码结合 VS Code 浏览项目的工作模式。表面上看，上述试用过程的确是浪费了一些时间，但很多软件工具、技术方法如果没有亲自尝试，便永远不会知道它们究竟是否适合自己的工作场景。考虑到自从 2004 年以来我一直将 Emacs 作为主力文字编辑与软件开发工具的情况，在我的工作流中持续拓展其应用范围——尤其是将其用于 HierBEM 的开发工作上——还是非常值得的。

{{ "2026-06-14-基于Emacs的C++ LSP还不足以应对实际项目开发" | backlink }}
