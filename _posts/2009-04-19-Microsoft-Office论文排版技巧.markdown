---
layout: post
title: Microsoft Office论文排版技巧
date: 2009-04-19
categories: [computer]
tags: [MS-Office,排版]
mathjax: false
---

# Table of contents
{:.no_toc}

* toc starts here
{:toc}

引言
====

经过了一个多月的"煎熬"，终于将博士论文撰写完毕并打印成册了。由于之前撰写博士课题结题报告就用的是Microsoft Office，自己也不想再麻烦，所以博士论文就直接基于该Word文档做了，也没有再使用TeX/LaTeX排版。准确地讲，排版这件事其实比不上我们去学习数学、物理或编程序等给自己带来的收获大。可能你投入了数天的气力去调整文档格式，最终只是得到了一个"通过论文格式审查"的必然结果。毕竟，排版的目的是为了"秀"给别人看的，于自己的益处不多，而且对于面临要毕业工作不搞科研的大多数同学来讲，可能就只这么一次撰写大论文的机会，因而排版就更是一件"吃力不讨好"的事情了。但正因为如此，这里把自己在此次排版博士论文过程中的一些小经验、小技巧总结出来以享诸位，以期能够提高大家今后撰写论文的效率，尽量减少在这件"吃力不讨好的事情"上所浪费的时间。

同时，需要说明的是，撰写本文的目的绝对不是为了向大家宣传使用盗版Microsoft Office，也绝对不是为了向大家宣传使用正版Microsoft Office。因此，本文的撰写采用的是GNU/Linux下的Openoffice办公套装软件，除了与Microsoft Office不能完全兼容外，其完全可以替代Microsoft Office，满足日常科研和学习的需求。

下面言归正传，介绍Word排版中的小技巧，其中许多内容都是通过VBA宏来实现的，可以大大减少我们的工作量。

样式与格式
============

对于带有格式的文档，文档内容与样式的分离是保证文档格式的统一、可变、易维护的关键。在撰写文档时，我们只需关心如何安排各部分之间的逻辑关系、组织结构，而暂时不需要考虑段落与文字的样式。确定出文档的整体框架后，就可以针对每个组织单元进行样式的设计。例如，一个文档可以分为文章题目、各级标题、正文文字、要点内容等四大部分，那么就可以分别为这四类逻辑内容设置相应的样式。这样做的好处是，我们可以设置不同的样式集，从而在保证文档内容不变的情况下得到不同排版效果的文档。例如，可以针对同一文档内容，分别制作出用于论文打印和会议海报的样式。在Microsoft Word中样式的创建与修改是通过"格式"菜单中的"样式与格式"来完成的。在撰写最终的毕业论文前，一定要先定义好文档所需的样式（可以先只起好样式的名字，等文章写完后再调整与各样式对应的段落与文字格式），而不要像许多人通常的做法：随手选中某一部分文字直接修改其样式，或者使用格式刷将样式刷来刷去，这样做的后果会很惨，很容易导致整个文档的格式全部乱掉，重新调整起来异常困难。而若事先定义好了与文档各逻辑组成部分对应的样式，则只要将该样式的定义内容进行修改，则全文中所有采用该样式的地方都会得到相应更新，这样做既省事、又安全可靠。举例说，我在博士论文中就分别设定了如下样式：一、二、三级标题，一行放置单个图片与一行并排放置两个图片的样式，图片与表格题注样式，参考文献条目样式，公式所在段落的样式等。

关于样式定义或修改对话框中的"自动更新"选项这里需要说明一下：若选中了该选项，则改变该样式后，所有继承于该样式的样式将全部得到相应的更新。所以，除非某一样式及其子样式具有稳定不变的风格要求时，才能使用自动更新选项以保证该样式自身和继承于它的所有样式得到同步更新。若非如此，则慎用此选项。例如，一个典型的情况便是：若将Text（即正文）这种最普通的样式设成了自动更新，则在你写某一段文字时，突然想将其变成item list（编号列表）样式，然后你点击了item list按钮，随后就会发现文档中所有Text段落均给编上号码了。这就是由于你点了item list按钮，则相当于继承Text样式新生成了一个Text + item list样式，接着就是全文的自动更新\...后果很严重!

公式、图、表的编号与引用
========================

图、表的自动编号与引用是很方便的，直接在Microsoft Word中插入"题注"或选择交叉引用则可以搞定。公式的编号也可以用Word来做，但是在引用公式时，即需要得到"如式(\*.\*)"所示的效果，则不能再使用Word的交叉引用功能了：在插入公式的引用后，Word会将公式对象本身与公式编号一齐插入到引用公式的地方。即使将插入的多余的公式对象删除也没有用：因为如果更新文档中的域，则在引用处又会重新出现公式对象。当然，如果你安装了MathType，则公式的引用就不存在上述问题。但这里给出一个我自己的解决方法，该方法采用VBA宏来实现"域代码"的自动写入，从而可以自动生成公式的编号与对公式的引用。

公式自动编号
------------

公式或者图、表的自动编号可以完全通过写入域代码来实现，而无需采用插入"题注"的方式。如果要生成形如"(4.13)"的编号（其中4为章号，13表示第4章内的第13个公式），其实就相当于有一个计数器，每生成一个公式或图、表对象，该计数器的值就加1；若遇到新的一章，则该记数器清零。将该计数器的值与章号结合，就可以得到形如"(4.13)"的公式编号。写成域代码如下：

```
styleref 1 \s \*mergeformat
seq counter \* arabic \s 1 \*mergeformat
```

其中，`styleref 1 \s \*mergeformat`生成章号；`seq counter \* arabic \s 1 \*mergeformat`生成对象编号。`counter`是编号对象的计数器名称。例如，为了对公式、图、表分别自动编号，其计数器分别起名为：`eqn`, `fig`, `tab`。`\* arabic`表示以阿拉伯数字的方式显示自动编号。

为了引用某公式或图、表，则需要先选中其编号，然后插入书签，并给它起一个书签名。然后，就可以用下面的域代码引用该书签，得到的效果就是在引用处插入公式或图、表的编号：

```
ref bookmark_name \h
```

域代码的手动插入可以通过Ctrl+F9来实现，但较为麻烦。于是，将上述对象自动编号、添加书签与引用书签的过程写成VBA宏：

`label_object`：自动生成对象编号。其中会提示输入上述计数器`counter`的名字，这样可以实现对不同的对象分别自动编号。

`add_bookmark`：在选中的对象编号处生成一个书签。其中会提示输入书签的名字。只有生成了书签，才可以在文档中引用该对象。

`ref_object`：在引用处插入被引用对象的编号。其中会提示输入对象书签的名字。对象编号处书签名字的查看，可以直接用快捷键`Ctrl+F5`。

公式、图片、表格的排版
======================

公式的排版
----------

论文中的公式格式通常是这样的：公式对象在文档正中居中放置，而公式编号在文档最右侧右对齐。这个样式并不是我们通常所用的"左、中、右对齐"或"两端对齐"。有不少人的处理方法是生成一个一行三列表格。中间的一个单元设置为居中对齐，其中插入公式对象；右边的单元格设置为右对齐，且单元的cell padding距离应设为零，其中写入公式的编号。这样的做法颇为麻烦。其实，只需要采用制表位就可以很容易实现公式与编号的对齐。为此，需专门为公式新建一个样式。其中的段落间距等等则按照常规来设置，除此之外，需要在文档的正中央设置一个对齐属性为"居中"的制表位，在版芯最右侧位置处设置一个右对齐的制表位。这样，在插入公式前，首先将其所在段落设为上述新建的样式。然后，按一次TAB键，就可以看到光标移到了文档的正中央，此时输入公式对象，则它以文档中央为基准居中对齐。接下来，再按一次TAB键，光标便移动至文档的最右端，此时运行`label_object`宏插入公式编号，该编号自动以文档最右端为基准右对齐。

图片的排版
----------

图片的格式通常就是一行放置一个或一行并排放置两个图片。表格就只有一行放置一个的情况。对于一行放置一个对象的排版，只需新建一个"居中"的段落样式即可。对于一行并排放置两个图片的情况，则可以采用类似上述公式排版的方法，利用制表位来实现。我们可以新建一个名为"双图片"的样式，在版芯宽度的大约1/4与3/4处分别设置"居中"对齐的制表位。然后，通过按TAB键，则可以很快将光标移动至相应位置，然后在该处插入图片即可。

为了使全文图片的大小基本保持一致：例如，对于一行放置一个图片的情况，可以设置图片的宽度为版芯宽度的80%，为了保持图片原比例，图片的高度自动按比例缩放。对于一行放置两个图片的情况，可以设置图片宽度为版芯宽度的49%，图片高度按比例自动缩放。上述的调整过程写成宏`SetFig`与`SetTwoFig`。它们分别用来设置一行一个图片与一行两个图片格式下图片的宽度与高度。

表格的排版
----------

正规文献中的表格均为三线表。然而，用Word自动插入的表格都是完整的横竖线，之后只能通过手动去调整表格与单元格的边框，颇为麻烦。为此，写了一个宏`Set3LineTable`，只要将表格选中，运行该宏，就可以将其设置为三线表了，而且线的粗细都是符合我们学校论文的要求。

Excel chart的处理
=================

平时很多的实验数据和由这些数据绘制出图表如何保存？

用Matlab画出图导出成jpeg贴到word中？这应该是最要不得的做法：首先，大多数人图省事，随手贴入的都是彩色图。但毕业论文与发表的文章中一般均要使用黑白图片。更何况，绘出的图中坐标标注的字体、曲线线型等等一般都不合要求。将这些图存为jpeg，基本上就是在做无用功，等到写文章的时候，还得重新画的。如果重新的画的话，那当时用于绘图的程序都在哪儿？算例都在哪儿？这简直就是坠入了地狱。

用matlab绘图但将其存为.fig文件？看起来这是一个不错的方法。因为存成.fig文件时，图片和原数据都在（将其中曲线对应的数据取出还是有办法的，这里不再赘述）。但是，这毕竟还是有些麻烦，而且不太直观，无法直接看到与曲线对应的数据。

所以，这里还是推荐采用Excel来同时保存数据和根据这些数据画出的chart，这是一种非常直观和便捷的方式。虽然Excel并不是专门用来搞科研的工具软件，但是其功能还是够用的。如果不够你用，那么再去写一些VBA宏，就完全可以为所欲为。然而，在Excel中插入的chart通常都带有背景色，线型和marker也都跟我们学术绘图中常用的形式与符号大不相同，看起来极其古怪。所以，需要对chart中的各个元素属性进行修改，换成我们习惯的线型与marker（类似于Matlab中的线型与marker symbol就ok），将其设为黑白色。但这是一件非常让人吐血的麻烦事。所以，我也写了一个`SetChartStyle`宏，用于设置线型、marker symbol和大小，坐标系中的网格等。同时宏`SetTickNumberFormat`用于设置坐标轴数字标注的格式。这样一来，繁琐的事情在不到一秒中的时间就可以全部完成了，剩下的就只是微调一下chart的大小，然后就可以出炉了。

参考文献的编排
==============

首先要说的一点是，传统的手工一条一条输入文献记录的方式一去不复返了。现在很多的参考文献管理软件不只是可以当作文献数据库和笔记本来用，而且已有不少可以直接与Word结合，在文档中自动插入文献条目和引用编号。商业的软件就不说了，（即使你有钱）想必也没有谁愿意去为其掏腰包。这里推荐大家使用基于Firefox浏览器的Zotero文献管理平台。因为与该软件配合使用的有一个Word插件，可以自动按不同杂志社要求的格式插入文献，并在文章中插入文献的引用编号。是否好用我没有尝试，大家可以试用一下。当然，Jabref也是一个很好的文献管理软件，目前已有基于OpenOffice的插件。上述两个软件均具有很好的移植性，可以在Windows, Linux, Mac下使用。

我此次博士论文对参考文献的插入与处理没有基于上述插件，因为感觉自己做起来可能会更可靠、稳妥些。我采用的方案是：将参考文献记录以"编号列表"的格式插入到文档的末尾。然后，在需要引用文献的地方，利用Word自己的插入列表项"题注"功能，则可以将与文献记录对应的编号插入到当前文本中。然而，这个做法并不能保证参考文献记录按我们引用的顺序排列，所以在经过对论文多次的修改后，参考文献记录的先后顺序可能是一团乱麻。为此，我写了`ListCitationNumbers`宏，它可以从文档开头至末尾搜索形如`[num]`的字符串，并将其中的数字编号`num`取出记录。如果某一编号在前文已出现过，那么再次遇到该编号时就不再记录，即每个文献引用编号只记录一次。搜索过程结束后，VBA宏就将这些引用的文献编号依次输出显示，根据这个数字序列我们就可以看到哪些文献记录的引用顺序有问题。然后，手动调整文档末尾参考文献记录的顺序并更新全文档中的域就可以了。此次论文排版过程中，我就是用这个宏来帮助自己调整参考文献的引用顺序的，完全可用、可靠，根本不需再像以前那样用肉眼从头到尾地挨个去看、去核对，非常方便省心。

MathType的使用
==============

MathType 6与公式的快速输入
--------------------------

这里推荐大家使用最新版的MathType 6，因为其中加入了对LaTeX的支持：即，你可以使用LaTeX的语法来输入公式符号。当然这并不是要你去学习全套的LaTeX技术，你只需要记住常用的几个LaTeX数学公式命令即可。而且，这些命令通常都是很好记的，只要你知道相应的数学符号的英文单词，对应的LaTeX命令就与它差不多。

当然，MathType本身也有快捷键来输入一部分公式符号。例如：

```
Ctrl+h: superscript
Ctrl+l: subscript
Ctrl+j: both super and sub scripts
Ctrl+f: fraction
Ctrl+i: integration symbol
Ctrl+k,d: partial differentiation
Ctrl+g, a\~z: greek letters
```

将上述MathType快捷键与LaTeX命令相结合，便可以实现基本上无需鼠标点击就能很高效地在Word中插入数学公式。

MathType的中文输入
------------------

常会遇见这样的情况，在公式编辑器中输入好中文后，再退出回到Word发现中文根本无法显示。解决方法如下：

在MathType中选择"样式"、"定义"，出现"定义风格"对话框，选择其中的"高级"单选按钮，出现样式列表，在"全角文字"的下拉列表框中，将"宋体-方正超大字符集"改为"宋体"。这时虽然列表框中还是显示"宋体-方正超大字符集"，但是此时再编辑公式时已经可以显示所输入的汉字了。例如，不会将"中国"只显示"中"字。每当不能显示所有汉字时你都如法炮制，就可以解决问题了。

结语
====

以上介绍了Word排版中的一些小技巧，其中主要是通过VBA宏来实现的。对于排版中的常见问题如"含有公式的正文段落采用固定行距"、"分节实现不同的页眉与页脚"、"目录样式的修改"等则不再赘述。在Word排版方面，侯捷先生的《Word排版艺术》是相当好的书，大家可以参考。

下面附录中的代码则为本文正文中提到的VBA宏，大家需将其导入到Word文档中才能使用。而与Excel chart处理相关的宏则需要导入到Excel文件中。由于这些Word宏只是给自己排版使用的，所以最好将它们导入到自己的`Normal.dot`主模板文件中，而不要直接嵌入到你正在撰写的文档中。否则，当别人打开你的文档看到"该文档存在宏"的提示时，他就会怀疑你的文档有宏病毒而直接将其关掉。

附录1 Word VBA macros
=====================

```vb
Function GetCiteKey(ByVal startChar As String, _
                    ByVal endChar As String, _
                    ByRef keys As Collection, _
                    ByRef keyStart As Collection, _
                    ByRef keyEnd As Collection) As Boolean
                    
    Dim isfound As Boolean
    isfound = True
    
    Selection.Find.ClearFormatting
    With Selection.Find
        .Text = startChar
        .Forward = True
        .Wrap = wdFindStop
        .Format = False
    End With
    Do
    Selection.Find.Execute
    If StrComp(Selection.Text, startChar) = 0 Then
        Selection.MoveStart Unit:=wdCharacter, Count:=1
        Selection.MoveEndUntil cset:=endChar, Count:=wdForward
        If ExistInCollection(Selection.Text, keys) Then
        Else
            keys.Add (Selection.Text)
        End If
        Selection.MoveRight Unit:=wdCharacter, Count:=1
    Else
        isfound = False
    End If
    Loop While isfound
    
    If keys.Count > 0 Then
        GetCiteKey = True
    Else
        GetCiteKey = False
    End If
End Function

Sub ListCitationNumbers()
    Dim is_update As String
    is_update = InputBox("Update the fields?", "Update the fields?", 0)
    If (is_update = "1") Then
        Call UpdateAllFields
    End If
    
    ' list citations numbers without duplication

    Dim keys As New Collection
    Dim keyStart As New Collection
    Dim keyEnd As New Collection
    Dim isfound As Boolean
    Dim citeDict As Variant
    
    isfound = GetCiteKey("[", "]", keys, keyStart, keyEnd)
    
    If isfound Then
        MsgBox (CombineKeys(keys, ", "))
    Else
        MsgBox ("No citations!")
    End If
End Sub

Function CombineKeys(ByRef keys As Collection, _
                     ByVal delimiter As String) As String
    Dim str As String
    Dim i As Integer
    For i = 1 To keys.Count
        If i = keys.Count Then
            str = str & keys.item(i)
        Else
            str = str & keys.item(i) & delimiter
        End If
    Next i
    CombineKeys = str
End Function

Function ExistInCollection(item As String, _
                           list As Collection) As Boolean
    Dim flag As Boolean
    Dim i As Integer
    
    flag = False
    For i = 1 To list.Count
        If StrComp(item, list.item(i)) = 0 Then
            flag = True
            Exit For
        End If
    Next i
    
    ExistInCollection = flag
End Function

Sub ShowFields()
    Dim i As Integer
    For i = 1 To ActiveDocument.Fields.Count
        ActiveDocument.Fields.item(i).ShowCodes = True
    Next i
End Sub

Sub HideFields()
    Dim i As Integer
    For i = 1 To ActiveDocument.Fields.Count
        ActiveDocument.Fields.item(i).ShowCodes = False
    Next i
End Sub

Sub UpdateAllFields()
    '更新全文档的域
    Dim i As Integer
    For i = 1 To ActiveDocument.Fields.Count
        ActiveDocument.Fields.item(i).Update
    Next i
End Sub

Sub UpdateSecFields()
    '更新当前节的域
    Dim i As Integer
    For i = 1 To Selection.Sections(1).Range.Fields.Count
        Selection.Sections(1).Range.Fields.item(i).Update
    Next i
End Sub

Sub label_object()
    ' automatically insert numbers for equation, figure and table, or anything else
    Dim labelType As String
    ' three label types are supported: equation, figure, and table
    labelType = InputBox("Label type: ", _
                         "eqn? fig? tab?")
    If StrComp(labelType, "") <> 0 Then
        If StrComp(labelType, "eqn") = 0 Then
            Selection.TypeText Text:="("
        End If
      
        Selection.Fields.Add Range:=Selection.Range, _
                 Type:=wdFieldEmpty, _
                 Text:="styleref 1 \s \*mergeformat", _
                 preserveformatting:=False
        Selection.TypeText Text:="."
        Selection.Fields.Add Range:=Selection.Range, _
                 Type:=wdFieldEmpty, _
                 Text:="seq " + labelType + " \* arabic \s 1 \*mergeformat", _
                 preserveformatting:=False
        If StrComp(labelType, "eqn") = 0 Then
            Selection.TypeText Text:=")"
        End If
        Selection.Fields.Update
    Else
        MsgBox ("Nothing is done!")
    End If
End Sub

Sub add_bookmark()
    ' add bookmark to selected range
    Dim bookmark As String
    bookmark = InputBox("Bookmark: ", "Enter a bookmark name")
    If StrComp(bookmark, "") <> 0 Then
        If ActiveDocument.Bookmarks.Exists(bookmark) Then
            MsgBox ("Bookmark you've entered already exists!")
        Else
            ActiveDocument.Bookmarks.Add bookmark, Selection.Range
        End If
    End If
End Sub


Sub ref_object()
    ' insert a reference to an existing bookmark
    Dim bookmark As String
    bookmark = InputBox("Bookmark: ", "Enter a bookmark to be referenced")
    If StrComp(bookmark, "") <> 0 Then
        If ActiveDocument.Bookmarks.Exists(bookmark) Then
            Selection.Fields.Add Range:=Selection.Range, _
                     Type:=wdFieldEmpty, _
                     Text:="ref " + bookmark + " \h", _
                     preserveformatting:=False
        Else
            MsgBox ("The bookmark you've entered does not exist!")
        End If
    End If
End Sub

Sub SetDotLeader()
    For Each toc In ActiveDocument.TablesOfContents
        toc.TabLeader = wdTabLeaderDots
    Next toc
End Sub

Sub ListAllStyles()
    Dim aStyle As Style
    For Each aStyle In ActiveDocument.Styles
        If (aStyle.InUse = True) Then
            MsgBox aStyle.NameLocal
        End If
    Next aStyle
End Sub

Sub SetRefStyle()
    '设置参考文献条目的格式
    With Selection.ParagraphFormat
        .LeftIndent = MillimetersToPoints(0)
        .RightIndent = MillimetersToPoints(0)
        .SpaceBefore = 3
        .SpaceBeforeAuto = False
        .SpaceAfter = 0
        .SpaceAfterAuto = False
        .LineSpacingRule = wdLineSpaceExactly
        .LineSpacing = 16
        .Alignment = wdAlignParagraphJustify
        .WidowControl = False
        .KeepWithNext = False
        .KeepTogether = False
        .PageBreakBefore = False
        .NoLineNumber = False
        .Hyphenation = True
        .FirstLineIndent = 0
        
        .OutlineLevel = wdOutlineLevelBodyText
        .CharacterUnitLeftIndent = 0
        .CharacterUnitRightIndent = 0
        .CharacterUnitFirstLineIndent = -2
        .LineUnitBefore = 0
        .LineUnitAfter = 0
        .AutoAdjustRightIndent = True
        .DisableLineHeightGrid = False
        .FarEastLineBreakControl = True
        .WordWrap = True
        .HangingPunctuation = True
        .HalfWidthPunctuationOnTopOfLine = False
        .AddSpaceBetweenFarEastAndAlpha = True
        .AddSpaceBetweenFarEastAndDigit = True
        .BaseLineAlignment = wdBaselineAlignAuto
    End With
    With Selection.Font
        .NameFarEast = "宋体"
        .NameAscii = "Times New Roman"
        .NameOther = "Times New Roman"
        .Name = "Times New Roman"
        .Size = 10.5
        .Bold = False
        .Italic = False
        .Underline = wdUnderlineNone
        .UnderlineColor = wdColorAutomatic
        .StrikeThrough = False
        .DoubleStrikeThrough = False
        .Outline = False
        .Emboss = False
        .Shadow = False
        .Hidden = False
        .SmallCaps = False
        .AllCaps = False
        .Color = wdColorAutomatic
        .Engrave = False
        .Superscript = False
        .Subscript = False
        .Spacing = 0
        .Scaling = 100
        .Position = 0
        .Kerning = 1
        .Animation = wdAnimationNone
        .DisableCharacterSpaceGrid = False
        .EmphasisMark = wdEmphasisMarkNone
    End With
End Sub

Function TextWidth()
    '获取版心的宽度
    With Selection.Sections(1)
        TextWidth = .PageSetup.PageWidth - .PageSetup.LeftMargin - .PageSetup.RightMargin
    End With
End Function

Function TextHeight()
    '获取版心的高度
    With Selection.Sections(1)
        TextHeight = .PageSetup.PageHeight - .PageSetup.TopMargin - .PageSetup.BottomMargin
    End With
End Function

Sub SetFig()
    Dim ratio As Double
    ' 设置图片的属性：单张图片的宽度为版心宽度的 0.8，高度则自动按比例调整
    ratio = TextWidth * 0.8 / Selection.InlineShapes(1).Width
    
    Selection.InlineShapes(1).LockAspectRatio = msoTrue
    Selection.InlineShapes(1).Width = TextWidth * 0.8
    Selection.InlineShapes(1).Height = Selection.InlineShapes(1).Height * ratio
    Selection.InlineShapes(1).PictureFormat.Brightness = 0.5
    Selection.InlineShapes(1).PictureFormat.Contrast = 0.5
End Sub

Sub SetTwoFig()
    Dim ratio As Double
    ' 设置图片的属性：单张图片的宽度为版心宽度的 0.8，高度则自动按比例调整
    ratio = TextWidth * 0.49 / Selection.InlineShapes(1).Width
    
    '设置两个并排图片的宽度
    Selection.InlineShapes(1).LockAspectRatio = msoTrue
    Selection.InlineShapes(1).Width = TextWidth * 0.49
    Selection.InlineShapes(1).Height = Selection.InlineShapes(1).Height * ratio
    Selection.InlineShapes(1).PictureFormat.Brightness = 0.5
    Selection.InlineShapes(1).PictureFormat.Contrast = 0.5
End Sub

Sub Set3LineTable()
    With Selection.Tables(1)
        '''''''''''''''''''
        '设置外框，除去内框
        '''''''''''''''''''
        .Borders(wdBorderHorizontal).LineStyle = wdLineStyleNone
        .Borders(wdBorderVertical).LineStyle = wdLineStyleNone
        .Borders(wdBorderLeft).LineStyle = wdLineStyleNone
        .Borders(wdBorderRight).LineStyle = wdLineStyleNone
        .Borders(wdBorderBottom).LineStyle = wdLineStyleSingle
        .Borders(wdBorderTop).LineStyle = wdLineStyleSingle
        ' 注意：这里150pt即为1.5磅
        .Borders(wdBorderBottom).LineWidth = wdLineWidth150pt
        .Borders(wdBorderTop).LineWidth = wdLineWidth150pt
        
        '设置第一行单元线：宽度1磅
        .Rows(2).Borders(wdBorderTop).LineStyle = wdLineStyleSingle
        .Rows(2).Borders(wdBorderTop).LineWidth = wdLineWidth100pt
    End With
End Sub
```

附录2  Excel VBA macros
=====================

```vb
Sub SetTickNumberFormat()
   Dim x_format As String
   Dim y_format As String
  
   x_format = InputBox("X format", "X format", "General")
   y_format = InputBox("Y format", "Y format", "General")
  
   If (x_format <> "") Then
       ActiveChart.Axes(xlCategory).TickLabels.NumberFormat = x_format
   End If
  
   If (y_format <> "") Then
       ActiveChart.Axes(xlValue).TickLabels.NumberFormat = y_format
   End If
End Sub

Sub SetGrid()
   Dim is_major_on As String
   Dim is_minor_on As String
  
   is_major_on = InputBox("Major grid On? Off?", "Major grid On? Off?", "0")
   is_minor_on = InputBox("Minor grid On? Off?", "Minor grid On? Off?", "0")
  
   If (is_major_on <> "") Then
       If (is_major_on = "1") Then
           ActiveChart.Axes(xlCategory).HasMajorGridlines = True
           ActiveChart.Axes(xlValue).HasMajorGridlines = True
       Else
           ActiveChart.Axes(xlCategory).HasMajorGridlines = False
           ActiveChart.Axes(xlValue).HasMajorGridlines = False
       End If
   End If
  
   If (is_minor_on <> "") Then
       If (is_minor_on = "1") Then
           ActiveChart.Axes(xlCategory).HasMinorGridlines = True
           ActiveChart.Axes(xlValue).HasMinorGridlines = True
       Else
           ActiveChart.Axes(xlCategory).HasMinorGridlines = False
           ActiveChart.Axes(xlValue).HasMinorGridlines = False
       End If
   End If
End Sub

Sub SetChartStyle()
   ' config the total chart area
   ' ChartArea的大小不能用程序设置，只能手动调整
   ActiveChart.ChartArea.AutoScaleFont = False
   ActiveChart.ChartArea.Border.LineStyle = xlLineStyleNone
  
   ' config the plot area
   ActiveChart.PlotArea.Border.Color = RGB(0, 0, 0)
   ActiveChart.PlotArea.Border.Weight = xlThin
   ActiveChart.PlotArea.Interior.Color = RGB(255, 255, 255)
   ActiveChart.PlotArea.Width = ActiveChart.ChartArea.Width * 0.9
   ActiveChart.PlotArea.Height = ActiveChart.ChartArea.Height * 0.9
  
   ' config the axes
   ' 注意：下面的标签格式化编码与单元格式化中自定义编码中的格式化字符串相同
   With ActiveChart.Axes(xlCategory)
       'remove the major grid lines
       .HasMajorGridlines = False
       .HasMinorGridlines = False
       .TickLabels.AutoScaleFont = False
       .TickLabels.Font.Size = 10
       .TickLabels.NumberFormat = "General"
       .TickLabelPosition = xlTickLabelPositionNextToAxis
       .Crosses = xlMinimum '默认是在最小值处相交
    End With
  
   With ActiveChart.Axes(xlValue)
       .HasMajorGridlines = False
       .HasMinorGridlines = False
       .TickLabels.AutoScaleFont = False
       .TickLabels.NumberFormat = "General"
       .TickLabels.Font.Size = 10
       .Crosses = xlMinimum '默认是在最小值处相交
    End With
  
   ' legend config
   ActiveChart.Legend.AutoScaleFont = False
   ActiveChart.Legend.Position = xlLegendPositionBottom
   ActiveChart.Legend.Border.LineStyle = xlLineStyleNone
   ActiveChart.Legend.Font.Name = "宋体"
   ActiveChart.Legend.Font.Size = 12
  
   ' config the line series
   Dim i As Integer
   Dim pltp As String
   pltp = InputBox("Line? Marker? Or both?", "Line? Marker? Or both?", "1")
   If (pltp <> "") Then
       For i = 1 To ActiveChart.SeriesCollection.Count
           Select Case (pltp)
               Case "1"
                   SetLineStyle (i)    '设置不同的线型：只有线没有marker
                Case "2"
                   SetMarkerStyle (i)  '设置不同的marker: 只有marker 没有线
                Case "3"
                   SetLineMarkerStyle (i)  '同时设置marker与线型
            End Select
       Next i
   End If
  
   Call SetGrid
End Sub

Sub SetLineStyle(ByVal i As Integer)
   Dim ls_list As Variant
   ls_list = Array(xlContinuous, xlDash, xlDashDot, xlDot, xlDashDotDot)
  
   ActiveChart.SeriesCollection(i).MarkerStyle = xlMarkerStyleNone
   ActiveChart.SeriesCollection(i).Border.Color = RGB(0, 0, 0)
   ActiveChart.SeriesCollection(i).Border.LineStyle = ls_list(i - 1)
End Sub

Sub SetMarkerStyle(ByVal i As Integer)
   ' 这里的marker是空心的
   Dim mk_list As Variant
   mk_list = Array(xlMarkerStyleSquare, xlMarkerStyleDiamond, xlMarkerStyleTriangle, _
                   xlMarkerStyleX, xlMarkerStyleCircle)
                  
   ActiveChart.SeriesCollection(i).Border.LineStyle = xlLineStyleNone
   ActiveChart.SeriesCollection(i).MarkerStyle = mk_list(i - 1)
   ActiveChart.SeriesCollection(i).MarkerSize = 5
   ActiveChart.SeriesCollection(i).MarkerBackgroundColor = RGB(255, 255, 255)
   ActiveChart.SeriesCollection(i).MarkerForegroundColor = RGB(0, 0, 0)
End Sub

Sub SetLineMarkerStyle(ByVal i As Integer)
   Dim ls_list As Variant
   ls_list = Array(xlContinuous, xlDash, xlDashDot, xlDot, xlDashDotDot)
   ' 这里的marker是空心的
   Dim mk_list As Variant
   mk_list = Array(xlMarkerStyleSquare, xlMarkerStyleDiamond, xlMarkerStyleTriangle, _
                   xlMarkerStyleX, xlMarkerStyleCircle)
                  
   ActiveChart.SeriesCollection(i).Border.Color = RGB(0, 0, 0)
   ActiveChart.SeriesCollection(i).Border.LineStyle = ls_list(i - 1)
   ActiveChart.SeriesCollection(i).MarkerStyle = mk_list(i - 1)
   ActiveChart.SeriesCollection(i).MarkerSize = 5
   ActiveChart.SeriesCollection(i).MarkerBackgroundColor = RGB(255, 255, 255)
   ActiveChart.SeriesCollection(i).MarkerForegroundColor = RGB(0, 0, 0)
End Sub
```
