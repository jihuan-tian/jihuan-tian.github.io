---
layout: post
title: Use lstlisting environments for formatting source code in Beamer
date: 2024-05-11
categories: [computer]
tags: [LaTeX,Beamer,lstlistings]
mathjax: false
---

My old `lstlisting` setting related to source code style is as below.

```latex
\lstset{
  basicstyle=\ttfamily,
  keywordstyle=\color{blue}\bfseries,
  commentstyle=\color{comment-green},
  stringstyle=\color{magenta},
  columns=fullflexible,
  frame=single,
  breaklines=true,
  postbreak=\mbox{\textcolor{red}{$\hookrightarrow$}\space},
}
```

We can see an `mbox` (which can also be `hbox`) is used as the `postbreak` for line wrapping. When this setting is used in Beamer, there will be a compilation error, which provides no useful information about the cause.

```text
ERROR: Missing number, treated as zero.

--- TeX said ---
<to be read again> 
                   \kern 
l.23     auto 
              obj_func =
```

Solution: define a new box as below.

```latex
\newsavebox\redarrow
\sbox\redarrow{\raisebox{0ex}[0ex][0ex]{\ensuremath{\color{red}\hookrightarrow\space}}}
\lstset{postbreak=\usebox\redarrow}
```

My final configuration is like this, which depends on the document class type, since the said problem does not appear when the document class is different from `beamer`, such as `article`.

```latex
\makeatletter
\@ifclassloaded{beamer}{
  \newsavebox\redarrow
  \sbox\redarrow{\raisebox{0ex}[0ex][0ex]{\ensuremath{\color{red}\hookrightarrow\space}}}
  \lstset{postbreak=\usebox\redarrow}
}{\lstset{postbreak=\hbox{\textcolor{red}{$\hookrightarrow$}\space}}}
\makeatother
```

Meanwhile, there should be no indent for the source code within a `lstlisting` environment, because it formats the source code in a verbatim way. However, this can be remedied by manually specifying the amount of indent in the `gobble` option of the `lstlisting` environment, such as

```latex
\begin{lstlisting}[gobble=2, language=lang]
  #include <iostream>

  int main()
  {
    return 0;
  }
\end{lstlisting}
```

We can also use the package `lstautogobble` to automatically detect the indent in the source code. To enable it, add `autogobble=true` to the arguments of the `\lstset` macro.

**CAVEAT: when `lstlisting` environments are used in a frame, `fragile` or `containverbatim` should be added to the frame property list.** For example,

```latex
\begin{lstlisting}[autogobble=true, language=C++]
  auto obj_func =
    [this, &opt_control, &opt_variables, &opt_parameters, &factors](
      const std::vector<double> &x, std::vector<double> &grad) -> double {};
\end{lstlisting}
```

Otherwise, the following error appears.

```text
ERROR: Paragraph ended before \lstag@countleadingspaces was complete.

--- TeX said ---
<to be read again> 
                   \par 
l.141 \end{frame}
```

{{ "2024-05-11-use-lstlisting-environments-for-formatting-source-code-in-beamer" | backlink }}
