---
layout: post
title: 使用LibreOffice Writer文档构建个人管理与监督体系
date: 2020-02-20
categories: [computer,methodology]
tags: [LibreOffice,管理提升]
---

基于[Emacs Org mode的GTD任务管理方法]({% post_url 2019-04-30-以Emacs Org mode为核心的任务管理方案 %})可以有效地管理复杂繁多的任务，在具体与细节上进行很好的把控。而要从宏观层面把握项目进度，在中长期的时间尺度上纵观个人职业发展乃至整个人生的走向，则需要基于周、月、季度、半年、年末一系列时间节点上的整体规划、回顾、评估、反省与展望。目前，我基于LibreOffice Writer文档实现并实践了上述理念，从而形成了个人管理与监督体系。本文则简要介绍该文档的结构。

首先，我会为每年都创建一个这样的文档。文档内包含如下内容（以下层级列表在文档中分别赋以“标题一”、“标题二”等等的样式，从而可以在LibreOffice Writer导航栏中浏览整个文档的结构）：

* 项目整体规划与回顾

  * 年度规划（说明：这里可以针对官方项目、个人项目、学习、管理、事务等多个方面进行全年的远景规划，写下想要实现的个人目标和期望达到的人生状态。因为一年的时间毕竟比较长，年初通常带有一定激情的想法不一定符合现实，所以随着时间的推移，有可能需要对远景规划做一定的修改。因此，下面包含了年初和每个季度的版本。）

    * 年初版本

    * 第一季度末版本

    * 第二季度末版本

    * 第三季度末版本

  * 第一季度计划（说明：这是针对第一季度具体工作的安排。）

  * 第一季度回顾与小结（说明：这是针对第一季度执行情况的总结。）

  * 第二季度计划

  * 第二季度回顾与小结

  * 第三季度计划

  * 第三季度回顾与小结

  * 第四季度计划

  * 第四季度回顾与小结

* 周计划与回顾模板（说明：用于做周规划与回顾的模板。每周开始的时候，将其拷贝到后面相应的周编号下。）

* 第1周

* 第2周

* …

有了上述的基本架构后，对于具体的计划条目，可仿照Emacs Org mode为其设置不同的任务状态，并用不同的颜色区别。这包括：

* \[Finished\] 绿色：已完成

* \[Unfinished\] 红色：未完成

* \[Partly finished\] 蓝色：部分完成

* \[Unplanned finished\] 紫色：未列入计划但完成的

* \[Ongoing\] 土黄色：执行中

* \[Cancelled\] 红色删除线：取消

上述定义的文字样式可以预先在样式单中定义好。然后通过编写VBA宏命令，实现将每个任务状态对应的样式自动应用到当前光标所在的段落上，并在段首插入诸如\[Finished\]、\[Ongoing\]这样的字符。这样一来，就不需要每次都得用鼠标选中文字再设置样式了。VBA宏命令的源代码如下：

```vb
Sub SetTaskStatusString(cTaskStatus As String, cStyleName As String)
   Dim oDoc
   Dim oText
   Dim oViewCursor
   Dim oTextCursor
   Dim oSearchDescriptor
   Dim cTaskStatusListReg
   Dim oFoundAll
   Dim n

   oDoc = ThisComponent
   oText = oDoc.Text

   oViewCursor = oDoc.CurrentController.getViewCursor()
   oTextCursor = oText.createTextCursorByRange(oViewCursor)

   ' Select current paragraph using text cursor.
   oTextCursor.gotoStartOfParagraph(False)
   oTextCursor.gotoEndOfParagraph(True)

   ' Apply the specified character style for the current task status.
   oTextCursor.CharStyleName = cStyleName

   ' Insert the task status string.
   If Len(cTaskStatus) > 0 Then
      oTextCursor.getText.insertString(oTextCursor.getStart(), "\[" & cTaskStatus & "\] ", False)
   End If
End Sub

Sub SetFinished()
   SetTaskStatusString("Finished", "Finished task")
End Sub

Sub SetUnFinished()
   SetTaskStatusString("Unfinished", "Unfinished task")
End Sub

Sub SetPartlyFinished()
   SetTaskStatusString("Partly finished", "Partly finished task")
End Sub

Sub SetUnplannedFinished()
   SetTaskStatusString("Unplanned finished", "Unplanned finished task")
End Sub

Sub SetOngoing()
   SetTaskStatusString("Ongoing", "Ongoing")
End Sub

Sub SetCancelled()
   SetTaskStatusString("Cancelled", "Cancelled")
End Sub

Sub SetTodo()
   SetTaskStatusString("Todo", "Default Style")
End Sub

Sub SetDefaultStyle()
   SetTaskStatusString("", "Default Style")
End Sub

Sub Emphasize()
   SetTaskStatusString("", "Emphasis")
End Sub
```
    
为了进一步方便操作，可以再自定义一个工具栏，其中的按钮绑定了设定任务状态的VBA宏，如下图所示。
    
<p align="center"><img src="/figures/p69869614.jpg" alt="" /></p>

以上便是我在实际学习与工作中用于任务规划与回顾的文档模板。其实，具体采用什么形式与格式的文件来做这件事并不重要，关键是要能够让自己形成规划、执行、反馈、改进的闭环，以求持续地自我改进。此外，再顺便提一下，我之所以采用LibreOffice Writer作为主力办公软件，除了一方面它是开源软件外，还在于它提供了许多微软Office所没有的强大功能。例如，可以在LibreOffice文档中创建精确指向到另一个文件中某个位置处的超链接。这样一来，我的规划与回顾文档和我的日志、工作笔记文档等等都是彼此关联的，跳转浏览、相互对照起来非常方便。同时，由于这些超链接是以相对路径的格式存储的，所以只要文件之间的相对存储位置不发生变化，那么把整个文件树拷贝到不同的电脑或磁盘上，链接都是始终有效的。

{{ "2020-02-20-使用LibreOffice Writer文档构建个人管理与监督体系" | backlink }}
