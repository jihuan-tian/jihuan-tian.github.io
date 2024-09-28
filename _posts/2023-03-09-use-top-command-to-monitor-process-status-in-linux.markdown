---
layout: post
title: Use top command to monitor process status in Linux
date: 2023-03-09
categories: [computer]
tags: [command,Linux]
mathjax: false
---

<p align="center"><img src="/figures/2022-12-07_11-57-17-customize-top-command.png" alt="Customized top command" /></p>

# Typical operations

General

-   `s`: set the update interval
-   `W`: Save the option

Task list manipulation

-   `u`: Filter the task list by user name
-   `o`: Filter the task list by entering an expression, such as
    
    ```text
    COMMAND=...
    %MEM>10
    ```
-   `=`: Clear the filter for the task list
-   `f`: Customize the columns

Visualization effect

-   `z`: toggle color and mono mode
-   `x`: highlight the sort field, i.e. the whole corresponding column will be highlighted.
-   `y`: highlight running tasks
-   `b`: reverse the highlighting effect for the sorting field and running tasks


# Clarification of the time since program start

-   `TIMES+`: Total CPU time the task has used since it started. It has the granularity of hundredth of a second, i.e. its accuracy is 1/100 second. Its display format is, for example, `6000:25.03`, which means 6000 minutes, 25 seconds and 3 hundredths second. Also note that this is the total CPU time. If the process runs in n threads, the actual program execution time is about `TIMES+/n`.
-   `TIMES`: same as `TIMES+` but with second accuracy.

N.B. The time in `top` is the CPU time not the elapsed time. To get the latter, `ps` command with the option `etime` should be used instead ([reference](https://www.2daygeek.com/how-to-check-how-long-a-process-has-been-running-in-linux/)). The returned result has the date and time format `Days-Hours:Minutes:Seconds`.

```bash
ps -p 12698 -o etime
```

       ELAPSED
    2-03:50:03

{{ 2023-03-09-use-top-command-to-monitor-process-status-in-linux | backlink }}
