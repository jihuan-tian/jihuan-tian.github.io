---
layout: post
title: LibreOffice的特点与优势
date: 2020-11-14
disqus: y
---

继承自OpenOffice、诞生于2011年的LibreOffice经过多年的发展，如今将其作为微软Office办公套件的免费替代是完全可行且更胜一筹的。LibreOffice包含了Writer（文字处理）、Draw（矢量绘图）、Impress（演示文稿）、Calc（电子表格）、Base（数据库）、Math（数学公式）六个组件。本文列举出除Base与Math外各组件的主要特点和相对于微软Office的优势。

### 充分使用各组件的导航栏

LibreOffice的所有组件均具有方便对文档内容与所包含对象实现统览、管理和快捷跳转的导航栏。例如，Writer中的大纲结构、Calc中的各个工作表、文档中包含的图片、评论、表格、超链接均可以在导航栏中显示。

![](/figures/p77551865.jpg)

图1 LibreOffice Writer导航栏。

![](/figures/p77551866.jpg)

图2 LibreOffice Draw导航栏。

### 用好各组件中的样式单

将文档内容与其样式分离，是撰写结构化文档时应当采用的基本理念。采用这一方法的好处是，当我们在撰写文档内容的过程中，可以暂时地将其应当呈现的样式搁置一边，而完全专注于文档内在思想的提炼与逻辑链条的组织。有了清晰的文档结构，我们就可以给其中具有不同内容含义或逻辑功能的文本模块赋予不同的样式单名称，例如“标题”、“章”、“小节”、“注释”、“强调”等。我们要在完成了文档内容的撰写与编纂后，再去设计并定义这些样式单应该具有的属性，包括大小、间距、字体、缩进、颜色等。同时，我们还可以为同一个文档设计和制作出多份不同的样式单，以便适配不同的发布与出版目的，例如，用于演讲、作为讲义或技术报告等。

可以看出，采用文档内容与样式分离的方法，因为可以让我们更专注于内容本身，从而所产出文档内容的质量也就更高。而且，与以往随手用鼠标选择文本来设置样式以及在写作的过程中因反复调整样式而严重影响思路的工作方式相比，将文档内容与样式分离能够大大提升我们的写作效率。

在我们认识到将文档内容与样式分离的重要性之后，我们就可以发现LibreOffice已经全面地提供了样式单功能——不只是在Writer中，就连在Impress、Draw、Calc中都可以用样式单来组织与控制图形元素与表格内容的逻辑与样式。仅凭这一点，LibreOffice就足以成为我们的主力办公软件了。

![](/figures/p77551868.jpg)

图3 LibreOffice Draw样式单。

### 在Writer中使用文档超链接

使用LibreOffice Writer可在文档中插入相对路径的超链接，并且可以精确地定位至文档中具体的某一章节或某个书签，从而可以将多个文档相互关联起来，像是浏览Wikipedia那样阅读我们自己的文档集合。由于超链接可以创建为基于文件系统的相对路径，所以我们只要保证文件目录结构自身的一致性，就可以将整个文件树迁移或者同步至不同的设备上并保证链接始终有效。更详细的介绍可以参考我的这篇文章《[使用LibreOffice Writer构建个人日志系统]({% post_url 2020-07-27-使用LibreOffice Writer构建个人日志系统 %})》。

### 使用Draw的高级绘图功能

Draw的绘图功能相对于微软的Visio更为强大，几乎可以赶上专业的矢量绘图软件Inkscape了。而且Draw的操作相比Inkscape更为简单。例如，Draw提供了缩放、旋转、平移等图形变换操作，且允许用户选择变换的基准点。这一点对于在作图过程中保持已创建图形的基准位置不变与对齐关系是非常有用的。

例如，一个常见的情况就是，我们需要调整一组居中对齐的图形中某一个图形对象的宽度。由于该对象默认的变换基准点是左上角，所以在调整了其宽度后，它与其他对象之间居中对齐的关系就会被破坏。而若想在这个图形被缩放后仍旧保持居中，我们在LibreOffice中将变换的基准点选为该图形的中心即可。

![](/figures/p77551867.jpg)

图4 在LibreOffice Draw中选择图形的缩放基准点。

再者，在对图形进行旋转操作的时候，也可以任意指定旋转中心，这样就可以非常方便快捷地生成一组沿圆周均匀分布的图形了。

![](/figures/p77551869.jpg)

图5 在LibreOffice Draw中选择图形的旋转基准点。

此外，Draw所提供的贝塞尔曲线编辑、图形连接线的粘接点编辑、多个二维图形的布尔操作、由二维图形生成拉伸与旋转三维实体等功能也非常强大、实用，读者可以尝试一下。

### 利用LibreOffice的功能扩展

在LibreOffice的[官方网站](https://extensions.libreoffice.org/)上提供了非常丰富的扩展组件可供我们选择和安装。常用的扩展包括：

-   [TexMaths](https://extensions.libreoffice.org/en/extensions/show/texmaths-1)：在Writer、Impress、Draw中插入LaTeX数学公式。前提是需要在电脑上安装TeX/LaTeX排版系统。

![](/figures/p77551870.jpg)

图6 TexMaths扩展。

-   [AltSearch](https://extensions.libreoffice.org/en/extensions/show/alternative-dialog-find-replace-for-writer)：这是一个非常强大的在Writer文档中进行查找、替换的工具。支持使用正则表达式。被查换和替换的对象既可以是文本，也可以是样式。用户通过编写其所支持的宏命令，能够以批处理的方式执行多个查找、替换操作。关于AltSearch的实际使用案例可以参考我的这篇文章《[使用AltSearch格式化Kindle读书笔记]({% post_url 2020-11-14-使用AltSearch格式化Kindle读书笔记 %})》。

![](/figures/p77551871.jpg)

图7 AltSearch扩展。

-   [Code Highlighter](https://extensions.libreoffice.org/en/extensions/show/code-highlighter)：支持超过350种编程语言的代码高亮。
-   [Dmaths](https://extensions.libreoffice.org/en/extensions/show/dmaths)：功能丰富的数学作图工具。
-   [LanguageTool](https://extensions.libreoffice.org/en/extensions/show/languagetool)：开源的拼写检查软件，支持多种语言和不同的平台，包括PC独立软件，LibreOffice集成插件，Firefox集成插件。
-   [Export As Images](https://extensions.libreoffice.org/en/extensions/show/export-as-images)：将所有Impress中的幻灯片和Draw中的绘图页面批量导出为图片。
-   [Zotero LibreOffice Integration](https://extensions.libreoffice.org/en/extensions/show/zotero-libreoffice-integration)：与Zotero软件配合使用，用于学术文献的插入、引用。
