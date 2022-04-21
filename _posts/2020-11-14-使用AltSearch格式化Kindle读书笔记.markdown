---
layout: post
title: 使用AltSearch格式化Kindle读书笔记
date: 2020-11-14
categories: [computer]
tags: [LibreOffice,Kindle]
---

[AltSearch](https://extensions.libreoffice.org/extensions/alternative-dialog-find-replace-for-writer)是LibreOffice Writer的一个用于自动化执行复杂文本替换操作的扩展，能够在不需要复杂编程的条件下进行一些文档格式的手动与批量转换和调整。该扩展除了支持普通文本与正则表达式的查找与替换外，还能够进行文本与段落样式的匹配与替换，这是其他的排版软件，包括微软的Office，所不具备的。利用这些功能，将其写为简单的批处理脚本，就可以自动地格式化文件，满足常见的学习与工作需求，大大提高工作效率。本文以格式化由Kindle 导出的笔记为例，介绍AltSearch的基本使用方法。

由Kindle iPad版导出的芝加哥格式的笔记直接存为LibreOffice Writer文件，其格式基本与纯文本无异，并不适合结构化的浏览或发布为豆瓣笔记。所以，需要对文本格式进行调整。对此，首先在LibreOffice Writer中点击绿色望远镜按钮，打开AltSearch对话框：

<p align="center"><img src="/figures/p77551963.jpg" alt="" /></p>

然后依次执行如下步骤：

1. 删除`标注（黄色）`之类的标记和后面的（原版书）页码：

   - 搜索：`^标注\(.*\)\s*-\s*第\s*\d+\s*页·`
   - 替换为空字符

2. 搜索`笔记`并删除后面的（原版书）页码：

   - 搜索：`^(笔记\s*-\s*)第\s*\d+\s*页·`
   - 替换：`\1`

3. 将`位置`替换为`P`并将其与下一行合并：

   - 搜索：`位置\s*(\d+)\s*\p`
   - 替换:`P\1`

4. 将所有段落设为`Quotations`样式：

   - 搜索：`.*`
   - 替换：`\P{Quotations}`

5. 将所有以`笔记`开头的段落设为`Text Body样式：

   - 搜索：`^\s*笔记`
   - 替换：`\P{Text Body}`

上述步骤手动操作起来比较繁琐，我们可以利用AltSearch的批处理模式将其写为脚本。点击AltSearch对话框中的`Batch`按钮：

<p align="center"><img src="/figures/p77551961.jpg" alt="" /></p>

在如下打开的批处理模式对话框中点击`Edit`，打开文本编辑器编辑脚本。需要注意的是，如果是第一次运行AltSearch，点击`Edit`后会提示使用什么编辑器进行编辑，直接输入编辑器的命令名确认即可。

<p align="center"><img src="/figures/p77551966.jpg" alt="" /></p>

然后，将下面的脚本拷贝到文件末尾`[End]`的前一行即可。

```
[Name] Process the selected Kindle notes in Chicago format
  [Parameters]   MsgOff Regular CurrSelection

  [Find]^标注\(.*\)\s*-\s*第\s*\d+\s*页·
  [Replace]
  [Command] ReplaceAll

  [Find]^(笔记\s*-\s*)第\s*\d+\s*页·
  [Replace]\1
  [Command] ReplaceAll

  [Find]位置\s*(\d+)\s*\p
  [Replace]P\1 
  [Command] ReplaceAll
  
  [Find].*
  [Replace]\P{Quotations}
  [Command] ReplaceAll
  
  [Find]^\s*笔记
  [Replace]\P{Text Body}
  [Command] ReplaceAll
```

可以看出，这个脚本的语法非常简单：方括号中的单词表示需要执行的命令，括号之后则为该命令执行所需的参数。目前用到命令有：

1. `Name`：定义脚本功能名称。

2. `Parameters`：指定脚本功能执行时的参数，包括：

   - `MsgOff`：关闭提示信息。
   - `Regular`：使用正则表达式查找与替换。
   - `CurrSelection`：仅操作当前选中的文本。

3. `Find`：指定待查找的文本或正则表达式。

4. `Replace`：指定需替换的文本或样式

   - `\1`：反斜线后加一个数字N，表示正则表达式中第N括号中匹配的部分。
   - `\P{Paragraph style name}`：将名称为`Paragraph style name`的段落样式应用于查找到的文本。该段落样式需事先在LibreOffice Writer中定义好。

5. `Command`：指定需要执行的命令。`ReplaceAll`则表示对所有匹配的文本执行替换。

更多AltSearch的功能可以查阅其说明书。

接下来，点击`Refresh`钮，则可以看到刚才新添加进去的脚本功能：

<p align="center"><img src="/figures/p77551971.jpg" alt="" /></p>

这时，在LibreOffice Writer选中所有需要处理的文本，在AltSearch对话框中选中需要执行的脚本功能，点击`Execute`，便可以完成自动化处理工作。最后，根据个人需要，可以再手动设置Kindle图书中各个章节的标题样式。至此，就可以得到一份漂亮的读书笔记了。
