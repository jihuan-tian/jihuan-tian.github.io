---
layout: post
title: General work flow of writing a test case for the Galerkin BEM project
date: 2024-03-07
categories: [computer]
tags: [bem,hierbem,CMake,unit-test]
mathjax: false
---

With the help of my college classmate, we&rsquo;ve setup `Catch2` based unit test platform for the Galerkin BEM project. This is crucial for guaranteeing the correctness of a scientific software library which is gradually growing and becoming complicated. After several months of getting familiar with it, the work flow of writing and using a C++ test case becomes solidified, which is introduced in this article.

Assume the test case name is `foo`, which is created inside the folder `tests/foo`.

-   Call `${CMAKE​_CURRENT​_SOURCE​_DIR}/gen_data.m` Octave script from C++ to produce the input data of the test case in the file `${CMAKE​_CURRENT​_SOURCE​_DIR}/foo.input`. This is optional.
    
    N.B. The value of `${CMAKE​_CURRENT​_SOURCE​_DIR}` can be accessed from C++ via the constant `SOURCE_DIR`. This is setup in the `CMakeLists.txt` file of the test case `foo` as a definition associated with the target. Then C++ can locate the Octave script `gen_data.m` and execute it.
    
    ```cmake
    set(_target test-foo)
    target_compile_definitions(${_target}
      PUBLIC SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}")
    ```

-   Test case generate results into the file `${CMAKE​_CURRENT​_SOURCE​_DIR}/foo.output` in the format which can be loaded by Octave.
-   Call `${CMAKE​_CURRENT​_SOURCE​_DIR}/process.m` Octave script from C++. In `process.m`,
    -   Load the result file `${CMAKE​_CURRENT​_SOURCE​_DIR}/foo.output`.
    -   Run the Octave implementation of the C++ algorithm.
    -   Compare the C++ and Octave results. Usually, relative error is computed.
-   C++ check the relative error computed by `process.m` via `Catch2`.

After each compilation of the test case, `${CMAKE​_CURRENT​_SOURCE​_DIR}/process.m` and `${CMAKE​_CURRENT​_SOURCE​_DIR}/draw.m` will be automatically copied into the folder of the test case binary file by CMake.

```cmake
add_custom_command(
  TARGET ${_target}
  POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/process.m
          ${CMAKE_CURRENT_BINARY_DIR}/process.m)

add_custom_command(
  TARGET ${_target}
  POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/draw.m
          ${CMAKE_CURRENT_BINARY_DIR}/draw.m)
```

Then, the test case can be manually run in this folder and the Octave scripts `process.m` and `draw.m` can be executed for validation and visualization.

{{ "2024-03-07-general-work-flow-of-writing-a-test-case-for-the-galerkin-bem-project" | backlink }}
