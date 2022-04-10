---
layout: post
title: 将Emacs Org mode用于GTD任务管理
date: 2019-09-30
categories: [thoughts]
tags: [管理提升,Org-mode,Emacs,GTD]
---

# Table of contents
{:.no_toc}

* toc starts here
{:toc}

在[《以Emacs Org mode为核心的任务管理方案》]({% post_url 2019-04-30-以Emacs Org mode为核心的任务管理方案 %})中，我简要介绍了如何围绕Emacs Org mode构建个人任务管理系统的基本思路与方法。因为Org mode体系庞大、功能繁杂，本文仅以提纲契领的方式介绍不同环节在Org mode中的操作与实现。更为具体与精密的功能机制和实施细节以查阅[Org mode参考手册](https://orgmode.org/manual/index.html)为宜。

# 定义任务状态关键词

变量`org-todo-keywords`用于指定可给任务赋予的状态关键词。该变量的值为一组序列（sequence）构成的列表。每一个序列以符号`type`或`sequence`开头，其后则是一组用于定义任务状态关键词的字符串。若这一组字符串中的某一个为竖线`|`，则在竖线前的所有字符串代表任务未结束的状态，之后的则代表任务结束的状态。若没有竖线，则仅最后一个字符串代表任务结束的状态，其之前所有的字符串都代表任务未结束的状态。这样的`type`或`sequence`序列可以定义多个。但是对于一般的任务管理来说，只定义一个就足够了。

此外，用户可以在`type`或`sequence`序列中的每个关键词字符串末尾写上一对括号，令其中包含一个字母。该字母便是对应关键词的快捷方式。当用户将光标置于某个任务条目上时，按下`C-c C-t`后并输入快捷方式，可将任务直接设为指定的状态。

我所使用的任务状态关键词设置如下：

```lisp
(setq org-todo-keywords
 '((sequence "TODO(t)" "ONGOING(o)" "MAYBE(m)" "WAIT(w)" "DELEGATED(d)" "|"
     "DONE(f)" "CANCELLED(c)" "STUCK(s)")))
```

# 任务组标签

在Org mode中，当光标处于某个任务条目上时，按下快捷键`C-c C-c`，即可为该任务设置标签。对于任务组，我会为其加上标签`TG`予以识别。默认情况下，某一层级条目的标签会被其所包含的所有子条目继承。这样一来，当想要通过搜索标签`TG`来查看所有任务组时，具体的细节任务也会一并列出，干扰视线。为此，需要设置变量`org-tags-exclude-from-inheritance`，对`TG`标签禁用继承。

```lisp
(setq org-tags-exclude-from-inheritance '("TG"))
```

# 自定义日程视图

## 自定义日程视图简介

Org mode中的日程视图（Agenda view）具有强大的模式匹配与搜索能力。通过过滤用户指定的任务状态关键词、标签、时间戳以及自定义条件，可以生成几乎可以满足用户任何需求的视图。以数学的方式来讲，这就相当于将整个复杂的任务体系投影到我们所关注的不同空间中，对任务进行多角度地审视与把握，从而使我们在做任务管理的时候达到理清思路、聚集重点、不放过任何细节的良好效果。

日程视图的定义需要通过设置变量`org-agenda-custom-commands`来完成。该变量是一个列表，其中的每一项对应一个视图设置。这个视图设置的基本格式为：

```lisp
(key desc type match settings files)
```

各部分的含义如下：

* `key`：当用户执行`org-agenda`命令时，会弹出`*Agenda Commands*`缓冲区，其中包含了系统默认和用户自定义的日程视图。每个日程视图均对应一个快捷字母。当用户按下这个字母时，则可以进入到相应的视图中查看。这里的`key`则代表快捷字母。

* `desc`：日程视图的说明。

* `type`：日程视图的类型，即用于定义将哪些类型的任务条目收录到该视图中。通常用到的类型有：

  * `agenda`：基于日或周的日程。

  * `todo`：包含有特定状态关键词的任务条目。

  * `alltodo`：所有处于未结束状态的任务条目，即，状态关键词为`org-todo-keywords`设置中竖线之前的。

  * `tags`：包含指定标签的条目。

* `match`：用于指定与之前`type`对应的匹配条件。例如，当`type`为`todo`时，`match`若为`"DONE"`，则匹配状态关键词为DONE的任务条目。如果没有匹配条件需要定义，则这一项为空字符串。

* `settings`：用于指定匹配时应满足的一系列选项设置。`settings`的格式类似用于定义局部变量的`let`形式，即，
  
  ```lisp
  ((option1 value1) (option2 value2) ...)
  ```

  常用的选项有：

  * `org-agenda-skip-function`：用于设定忽略条件的函数对象。

  * `org-agenda-overriding-header`：用于设定日程视图的台头提示信息。

  * `org-agenda-files`：这个变量的值是一个字符串列表，用于指定从哪些Org文件中提取信息。默认情况是从所有的Org文件中提取信息。

* `files`：用于指定当执行了`org-store-agenda-views`命令后需要将日程视图自动导出的文件。可以是HTML格式，也可以是纯文本格式。这个功能非常方便：当用户将所有的视图都定义好后，可以定期地直接将其全部导出。既可以放在HTTP服务器上统一浏览，也可以在审阅后存档，形成历史记录。

随着日积月累，当用户定义的日程视图比较多时，管理起来就会较为混乱，同时可供绑定的字母快捷键也开始不够用。为此，可以将功能、类别相似的视图归为一组。这个组视图在`org-agenda-custom-commands`中的定义方式为：

```lisp
(Group-key . desc)
```

其中的`Group-key`为一个字母，指定了组的快捷键。

当组定义好了之后，随后便可以定义组内的各个日程视图。每个日程视图的定义与前面所述相同，

```lisp
(Group-KeyView-Key desc type match settings files)
```

只是其`key`为两个字母，第一个字母为`Group-key`，第二个字母`View-key`为日程视图自己的快捷捷。当用户执行`org-agenda`时，按下`Group-key`先进入组视图，再按下`View-key`则进入到指定的日程视图中。

有了以上对于Org mode中日程视图的基本了解，下面便介绍一下我定义的几种视图及其配置。

## 默认日程视图

该视图基于Emacs Org默认的Agenda视图，排除了那些仅包含时间戳但没有TODO关键词的条目。为此，需要定义一个排除函数`tjh/org-agenda-skip-only-timestamp-entries`：

```lisp
;; Skip entries which only have timestamp but no TODO keywords.
(defun tjh/org-agenda-skip-only-timestamp-entries ()
  (org-agenda-skip-entry-if 'nottodo 'any))
```

然后，定义总的默认视图与各个项目自己的默认视图。

```lisp
(setq org-agenda-custom-commands
      '(
        ......
	;; Display general agenda for each project.
        ("A" . "Default agenda view")
        ("Aa" "Agenda for all projects"
         agenda ""
         ((org-agenda-skip-function 'tjh/org-agenda-skip-only-timestamp-entries)
          (org-agenda-overriding-header "Agenda for all projects: "))
         "/agenda/docs/orgs/org-html-exports/Agenda-All.html")
        ("Ab" "CloudSim"
         agenda ""
         ((org-agenda-skip-function 'tjh/org-agenda-skip-only-timestamp-entries)
          (org-agenda-overriding-header "Agenda for CloudSim: ")
          (org-agenda-files '("/agenda/docs/orgs/CloudSim.org")))
         "/agenda/docs/orgs/org-html-exports/Agenda-CloudSim.html")
        ("Ac" "Study"
         agenda ""
         ((org-agenda-skip-function 'tjh/org-agenda-skip-only-timestamp-entries)
          (org-agenda-overriding-header "Agenda for study: ")
          (org-agenda-files '("/agenda/docs/orgs/Math.org"
			      "/agenda/docs/orgs/Computer.org")))
         "/agenda/docs/orgs/org-html-exports/Agenda-Study.html")
        ("Ad" "Personal"
         agenda ""
         ((org-agenda-skip-function 'tjh/org-agenda-skip-only-timestamp-entries)
          (org-agenda-overriding-header "Agenda for personal affairs: ")
          (org-agenda-files '("/agenda/docs/orgs/Personal.org")))
         "/agenda/docs/orgs/org-html-exports/Agenda-Personal.html")
        ("Az" "2019-FOTO"
         agenda ""
         ((org-agenda-skip-function 'tjh/org-agenda-skip-only-timestamp-entries)
          (org-agenda-overriding-header "Agenda for 2019-FOTO: ")
          (org-agenda-files '("/agenda/docs/orgs/2019-FOTO.org")))
         "/agenda/docs/orgs/org-html-exports/Agenda-2019-FOTO.html")
        ("Ay" "Official"
         agenda ""
         ((org-agenda-skip-function 'tjh/org-agenda-skip-only-timestamp-entries)
          (org-agenda-overriding-header "Agenda for official affairs: ")
          (org-agenda-files '("/agenda/docs/orgs/Official.org")))
         "/agenda/docs/orgs/org-html-exports/Agenda-Official.html")
        ......
        ))
```

## 截止日期日程视图

该视图列出所有加了`DEADLINE`时间戳的任务。为此，需要事先定义一个函数`tjh/org-agenda-skip-not-deadline-entries`，用于忽略不包含`DEADLINE`时间戳的条目。

```lisp
;; Skip entries which are not deadlines.
(defun tjh/org-agenda-skip-not-deadline-entries ()
 (org-agenda-skip-entry-if 'notdeadline))
 ```

然后，定义总的截止日期视图与各个项目自己的截止日期视图。

```lisp
(setq org-agenda-custom-commands
    '(
    ......
    ;; Display all tasks with deadline.
    ("D" . "Agenda view for deadlines")
    ("Da" "Agenda view for all deadlines"
     agenda ""
     ((org-agenda-skip-function 'tjh/org-agenda-skip-not-deadline-entries)
     (org-agenda-overriding-header "All deadlines: "))
     "/agenda/docs/orgs/org-html-exports/Deadline-All.html")
    ("Dc" "Study"
     agenda ""
     ((org-agenda-skip-function 'tjh/org-agenda-skip-not-deadline-entries)
     (org-agenda-overriding-header "Deadlines for study: ")
     (org-agenda-files '("/agenda/docs/orgs/Math.org"
           "/agenda/docs/orgs/Computer.org")))
     "/agenda/docs/orgs/org-html-exports/Deadline-Study.html")
    ("Dd" "Personal"
     agenda ""
     ((org-agenda-skip-function 'tjh/org-agenda-skip-not-deadline-entries)
     (org-agenda-overriding-header "Deadlines for personal affairs: ")
     (org-agenda-files '("/agenda/docs/orgs/Personal.org")))
     "/agenda/docs/orgs/org-html-exports/Deadline-Personal.html")
    ("Dy" "Official"
     agenda ""
     ((org-agenda-skip-function 'tjh/org-agenda-skip-not-deadline-entries)
     (org-agenda-overriding-header "Deadlines for official affairs: ")
     (org-agenda-files '("/agenda/docs/orgs/Official.org")))
     "/agenda/docs/orgs/org-html-exports/Deadline-Official.html")
    ......
    ))
```

## 已完成任务日程视图

该视图列出总的和各个项目的已完成任务视图。为此，需要定义函数`tjh/org-agenda-skip-unfinished-entries`，用于忽略所有不包含`DONE`状态关键词的任务条目。

```lisp
;; Skip entries which are not finished.
(defun tjh/org-agenda-skip-unfinished-entries ()
 (org-agenda-skip-entry-if 'nottodo '("DONE")))
```

变量`org-agenda-custom-commands`中的对应设置如下：

```lisp
(setq org-agenda-custom-commands
    '(
    ......
    ;; Display all finished tasks.
    ("F" . "Agenda view for finished tasks")
    ("Fa" "Agenda view for all finished tasks"
     agenda ""
     ((org-agenda-skip-function 'tjh/org-agenda-skip-unfinished-entries)
     (org-agenda-overriding-header "All finished tasks: "))
     "/agenda/docs/orgs/org-html-exports/Done-All.html")
    ("Fc" "Study"
     agenda ""
     ((org-agenda-skip-function 'tjh/org-agenda-skip-unfinished-entries)
     (org-agenda-overriding-header "Finished tasks for study: ")
     (org-agenda-files '("/agenda/docs/orgs/Math.org"
           "/agenda/docs/orgs/Computer.org")))
     "/agenda/docs/orgs/org-html-exports/Done-Study.html")
    ("Fd" "Personal"
     agenda ""
     ((org-agenda-skip-function 'tjh/org-agenda-skip-unfinished-entries)
     (org-agenda-overriding-header "Finished tasks for personal affairs: ")
     (org-agenda-files '("/agenda/docs/orgs/Personal.org")))
     "/agenda/docs/orgs/org-html-exports/Done-Personal.html")
    ("Fy" "Official"
     agenda ""
     ((org-agenda-skip-function 'tjh/org-agenda-skip-unfinished-entries)
     (org-agenda-overriding-header "Finished tasks for official affairs: ")
     (org-agenda-files '("/agenda/docs/orgs/Official.org")))
     "/agenda/docs/orgs/org-html-exports/Done-Official.html")
    ......
    ))
```

# GTD流程

## 收集箱

通过列出所有尚未计划的任务条目，则可以构成GTD流程中的收集箱。为此，需要定义函数`tjh/org-agenda-skip-scheduled-entries`，用于忽略所有已经加了时间戳、状态关键词为`ONGOING`、`WAIT`或`DELEGATED`的任务条目。同时，包含了`TG`标签的任务也被排除在外。这是因为任务组只是具体任务的容器，故不参与到实际任务的安排中。

```lisp
;; Skip unscheduled entries.
(defun tjh/org-agenda-skip-scheduled-entries ()
 (org-agenda-skip-entry-if 'timestamp
               'todo '("ONGOING" "WAIT" "DELEGATED")
               'regexp ":TG:"))
```

以下配置实现了总的与各个项目的收集箱。

```lisp
(setq org-agenda-custom-commands
    '(
    ......
    ;; Inbox for displaying unscheduled tasks.
    ("I" . "Inbox")
    ("Ia" "Inbox for all unfinished TODOs"
     alltodo ""
     ((org-agenda-skip-function 'tjh/org-agenda-skip-scheduled-entries)
     (org-agenda-overriding-header "Inbox items: "))
     "/agenda/docs/orgs/org-html-exports/Inbox-All.html")
    ("Ic" "Study"
     alltodo ""
     ((org-agenda-skip-function 'tjh/org-agenda-skip-scheduled-entries)
     (org-agenda-overriding-header "Inbox items for study: ")
     (org-agenda-files '("/agenda/docs/orgs/Math.org"
           "/agenda/docs/orgs/Computer.org")))
     "/agenda/docs/orgs/org-html-exports/Inbox-Study.html")
    ("Id" "Personal"
     alltodo ""
     ((org-agenda-skip-function 'tjh/org-agenda-skip-scheduled-entries)
     (org-agenda-overriding-header "Inbox items for personal affairs: ")
     (org-agenda-files '("/agenda/docs/orgs/Personal.org")))
     "/agenda/docs/orgs/org-html-exports/Inbox-Personal.html")
    ("Iy" "Official"
     alltodo ""
     ((org-agenda-skip-function 'tjh/org-agenda-skip-scheduled-entries)
     (org-agenda-overriding-header "Inbox items for official affairs: ")
     (org-agenda-files '("/agenda/docs/orgs/Official.org")))
     "/agenda/docs/orgs/org-html-exports/Inbox-Official.html")
    ......
    ))
```

## 规划

### Refile

使用`org-refile`命令（`C-c C-w`)可以将当前光标所在处的标题及其子树移动到另一个更高一级的标题下。默认情况下，子树会添加到这个新标题下的末尾。当然，也可以添加到最开始。这一点由变量`org-reverse-note-order`来控制。若执行`C-u C-c C-w`，则仅令光标跳转到指定的更高一级标题处而不移动子树。

### 设定时间戳

- 使用`C-c C-s`为任务设置`SCHEDULED`时间，即，开始着手处理任务的那一天，但对于任务执行具体需要多少时间并不作明确要求。这一点也是符合GTD的基本思想的。
- 使用`C-c C-d`为任务设置`DEADLINE`时间。

## 执行

### 估计执行任务所需时间

对于一个任务组及其包含的所有具体任务进行整体上的时间规划时，可以借助Org mode提供的列视图功能。在任务组标题下定义属性`COLUMNS`，用于指定列视图中各列的内容、标题与宽度。例如，

```
* TODO A big task to be handled.                    :TG:
  :PROPERTIES:
  :COLUMNS:  %75ITEM(Task) %8PRIORITY(Priority) %9TODO(Status) %8EFFORT(Effort){:} %16SCHEDULED %16DEADLINE
  :END:
```

其中，Effort列后的`{:}`用于指定对各行子任务的Effort进行求和。

然后，在任务组下定义各个具体任务。

```
* TODO A big task to be handled.                    :TG:
  :PROPERTIES:
  :COLUMNS:  %75ITEM(Task) %8PRIORITY(Priority) %9TODO(Status) %8EFFORT(Effort){:} %16SCHEDULED %16DEADLINE
  :END:
** TODO [#A] Task 1
** TODO [#C] Task 2
** TODO [#B] Task 3
```

之后，按`C-c C-x C-c`进入列视图模式进行规划，如图1所示。

<p align="center"><img src="/figures/p65763804.jpg" alt="图1 在列视图模式下估计任务的执行时间" /></p>
<p align="center">图1 在列视图模式下估计任务的执行时间</p>

### 任务列表视图的保存与导出

按`C-c C-x C-c`得到的列视图模式只是暂时地显示于Emacs的缓冲区而无法永久保存。为了保存列视图并导出，按`C-c C-x i`执行`org-insert-columns-dblock`命令。随后Emacs提示需要为什么范围的任务节点生成列视图。对此，有如下模式可供选择：

-   `local`：对光标所在节点及子树生成视图。
-   `global`：对整个文件中的标题节点生成视图。
-   `file:FILENAME`：对指定文件生成视图。
-   `LABEL`：对光标所在节点及子树中ID属性值为`LABEL`的节点生成视图。

一般来说，使用`local`选项对指定的任务组生成列视图就足够了。

回车确认后，则会在指定位置处插入`dynamic block`，如下所示：

```
* TODO [#A] Task planning for official project :TG:
  :PROPERTIES:
  :COLUMNS:  %70ITEM(Task) %8TAGS(Tags) %2PRIORITY(Priority) %9TODO(Status) %8EFFORT(Effort){:} %16SCHEDULED %16DEADLINE
  :END:
** Column view
#+BEGIN: columnview :hlines 1 :id local
| Task                                                  | Tags         | Priority | Status    | SCHEDULED        | DEADLINE         |
|-------------------------------------------------------+--------------+----------+-----------+------------------+------------------|
| Information scouting                                  | :TG:         |          | DONE      |                  |                  |
| Paper survey about segmentation using active contours |              | B        | DONE      | <2019-05-29 Wed> | <2019-05-30 Thu> |
| Theoretical derivation                                | :TG:         |          | TODO      |                  |                  |
| Derivation of existence and uniqueness theorems       |              | A        | TODO      | <2019-06-03 Mon> | <2019-06-04 Tue> |
...
#+END:
```

注意，由于上述生成的列表视图包含了时间戳，如果直接将其放在标题节点“Task planning for official project :TG:”下，则会在默认的日程视图中的相应日期处加入这个条目，而这是我们所不希望的。为此，需要创建一个不包含`TODO`关键词的子节点，然后将列表视图的内容放在它的下面。之后，自定义的默认日程视图会调用函数`tjh/org-agenda-skip-only-timestamp-entries`将该条目忽略。

之后，如果节点内容有所变动，按`C-c C-c`或`C-c C-x C-u`执行`org-dblock-update`更新上述`dynamic block`。这样，列视图就可以随org文件一起保存下来。

选中上述内容，按`C-c C-e`则可以将其导出为不同的格式。目前，由于Windows Cygwin下的htmlize功能有问题，我倾向于导出为odt格式。之后，可以将odt文件中的表格拷贝到Calc中，作进一步的格式美化，如图2所示。

<p align="center"><img src="/figures/p65763805.jpg" alt="图2 在LibreOffice Calc中美化任务列表" /></p>
<p align="center">图2 在LibreOffice Calc中美化任务列表</p>

### 统计实际任务执行时间

在开始某项任务时，将光标放到该任务条目上，按快捷键`C-c C-x C-i`执行`org-clock-in`命令，即可对该任务进行计时。停止工作时，再按`C-c C-x C-o`执行`org-clock-out`命令，结束对该任务的计时。为了汇总显示执行各任务所花费的时间，按`C-c C-x C-r`执行`org-clock-report`命令，可对光标当前所在处的任务子树或者整个Org文件生成时间统计报告。

# 结语

本文概要地介绍了我在Emacs Org mode中进行GTD任务管理的具体操作与基本配置。然而这只是一个起点，还需要在实际的学习与研究中将这一套方法和流程反复使用、长期练习，才能够发挥其应有的效力。同时，也需要不断地积累关于任务管理和Org mode的相关知识，从而能够对这套方法和流程持续地改进、更新。最后，需要始终牢记的一点是，任务管理的关键不在于工具与技术，甚至都不在于管理方法和思想，而在于有效执行和有实质性的产出。这也正是任务管理的最终目的。
