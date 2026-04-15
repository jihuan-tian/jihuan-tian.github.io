---
layout: post
title: Cursor's xaver.clang-format extension does not support CUDA C++
date: 2026-04-15
categories: [computer]
tags: [Cursor, Emacs]
mathjax: false
---

<a id="orgc6ee94e"></a>

# Phenomenon

The default formatter for CUDA C++ in VS Code or Cursor is `ms-vscode.cpptools`. However, it produces different formatting results from the Emacs `clang-format` package.

However, if I set the formatter to `xaver.clang-format`, Cursor prompts me that `xaver.clang-format` does not support CUDA C++.


<a id="org9f6103f"></a>

# Solution

Still use the formatter `ms-vscode.cpptools`, but should additionally assign the path to `clang-format` to the setting `C_Cpp.clang_format_path`.

Related settings in `$HOME/.config/Cursor/User/settings.json` are below.

```json
"[cpp]": {
      "editor.defaultFormatter": "xaver.clang-format"
  },
"files.associations": {
  "*.hcu": "cuda-cpp",
  "*.h": "cpp"
},
"[cuda-cpp]": {
  "editor.defaultFormatter": "ms-vscode.cpptools"
},
"editor.defaultFormatter": "xaver.clang-format",
"editor.formatOnSave": true,
"C_Cpp.clang_format_path": "/usr/bin/clang-format",
"C_Cpp.clang_format_style": "file",
"clang-format.executable": "/usr/bin/clang-format",
```

Now I can edit source code in Emacs and Cursor at the same time. The reason for why I use them both is: Cursor has the advantage of code structure overview, visualization and navigation diffs, while Emacs is more efficient for code modification, pattern searching via `ripgrep`.

{{ "2026-04-15-xaver-clang-format-does-not-support-cuda-cpp" | backlink }}
