---
layout: post
title: ntheorem does not work with hyperref anymore
date: 2024-05-12
categories: [computer]
tags: [LaTeX]
mathjax: false
---

The following code is my previous configuration for loading the `ntheorem` package in LaTeX.

```latex
% Mathematical environment
%% standard: enable the standard set of theorems.
%% thmmarks: enable the automatic placement of endmarks, which should be used
%% together with the option amsmath when the amsmath package has been loaded.
%% thref: enables the extended reference features.
\usepackage{framed}
\makeatletter
\@ifclassloaded{beamer}{\newtheorem{remark}{Remark}}
{
  %% When the document class is not beamer, define the following theorem environments.
  \usepackage[standard, framed, amsmath, hyperref, thmmarks, thref]{ntheorem}
  % Define new mathematical environment.
  \newtheorem{mynote}{Note}
  \newtheorem{mycomment}{Comment}
}
```

After upgrading to Debian Bookworm with Texlive version 2022.20230122, my LaTeX documents could not be compiled successfully with the error as below. In addition, all hyperlinks for cross references were lost.

```text
ERROR: Argument of \@fifthoffive has an extra }.

--- TeX said ---
<inserted text> 
                \par 
l.5595       \State {\hyperref[algo:mmr]{MMR}
                                             ($M, M, M_1, M_2$)}
--- HELP ---
From the .log file...

I've run across a `}' that doesn't seem to match anything.
For example, `\def\a#1{...}' and `\a}' would produce
this error. If you simply proceed now, the `\par' that
I've just inserted will cause me to report a runaway
argument that might be the root of the problem. But if
your `}' was spurious, just type `2' and it will go away.
```

Initially, I though this was caused by the `hyperref` package (included in the `texlive-latex-base` Debian package), since it often conflicts with some other packages and the usual solution is to change their loading order. However, after I downloaded its latest version as a TDS zip file (it is convenient to use the TDS zip file format of a LaTeX package, because it can be installed by simply unzip the file to the desired `texmf` root folder.), new problems arose.

After a morning of trial-and-error, the culprit is the `thref` option used with the `ntheorem` package (included in the `texlive-latex-extra` package). Removing it solves the problem.

*Lessons learned: for a beginner or even an experienced user (but not a developer), the error messages reported by LaTeX interpreter are even more esoteric than those from the C++ compiler.*

{{ 2024-05-12-ntheorem-does-not-work-with-hyperref-anymore | backlink }}
