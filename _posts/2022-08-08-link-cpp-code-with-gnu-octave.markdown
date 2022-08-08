---
layout: post
title: Link C++ code with GNU Octave
date: 2022-08-08
categories: [computer]
tags: [C++,Octave,算法开发]
mathjax: false
---

# Table of contents
{:.no_toc}

* toc starts here
{:toc}

To realize the concept of [Ship of Theseus]({% post_url 2022-05-02-ship-of-theseus-and-scientific-software-development %}) for scientific software development, it is requisite to interface C++ libraries with GNU Octave. In the following, I&rsquo;ll introduce the key commands for compiling C++ source code and linking with Octave.


# Generate oct module

To generate an `oct` module, which is in binary format and can be directly called from an Octave session like a normal `.m` script, the command `mkoctfile` should be used.

```sh
mkoctfile [OPTIONS] oct_module.cc
```

`mkoctfile` calls the default C++ compiler, such as `g++`, and will automatically configures the necessary include path, library search path and library name for linking with Octave&rsquo;s core library `liboctave.so` (N.B. On Linux, this library is not located in `/usr/lib` but in `/usr/lib/x86_64-linux-gnu`). Moreover, in-house or third-party header files and libraries can be introduced into the compiling and linking process, which significantly expands the capability of our `oct` file to be implemented. Therefore, the command options of `mkoctfile` are quite similar to those of a C++ compiler. For example,

    -I DIR: include directory for searching header files.
    -D DEF: definition of compiler macros.
    -l LIB: library to be linked.
    -L DIR: directory for searching libraries.
    -c: compile but do not link.
    -g: enable debugging options.
    -o FILE: specify output file name.


# Generate standalone program

Instead of running a compiled `oct` in an Octave session, if we want to make a standalone C++ program which relies on the data structure and functions provided by Octave, execute `mkoctfile` with the `--link-stand-alone` option.

```sh
mkoctfile --link-stand-alone standalone_program.cc -o standalone_program.out
```

# Common flags and variables used by mkoctfile

If our C++ source code to be linked with Octave depends on other header files or libraries, we should provide correct compiler and linker options for `mkoctfile`. Common flags and variables are summarized as below.

-   For compiling and linking
    
    | Variable name | Meaning                                                | Default value |
    |------------- |------------------------------------------------------ |------------- |
    | `CC`          | C compiler                                             | `gcc`         |
    | `CXX`         | C++ compiler                                           | `g++`         |
    | `F77`         | Fortran compiler                                       | `gfortran`    |
    | `RANLIB`      | The ranlib command, which generates index for archive. | `ranlib`      |

-   For including header file and searching library
    
    | Variable name  | Meaning                       | Default value               |
    |-------------- |----------------------------- |--------------------------- |
    | `INCLUDEDIR`   | System wide include directory | `/usr/include`              |
    | `LIBDIR`       | System wide library directory | `/usr/lib/x86_64-linux-gnu` |
    | `LIBOCTAVE`    | Octave core library           | `-loctave`                  |
    | `LIBOCTINTERP` | Octave interpolation library  | `-loctinterp`               |

-   Preprocessor and compiler options
    
    | Variable name | Meaning                | Default value                                              |
    |------------- |---------------------- |---------------------------------------------------------- |
    | `CPPFLAGS`    | C preprocessor flags   | `-Wdate-time -D_FORTIFY_SOURCE=2`                          |
    | `CFLAGS`      | C compiler flags       | `-g -O2 \`                                                 |
    |               |                        | `-fdebug-prefix-map=/build/octave-d7p05X/octave-4.4.1=. \` |
    |               |                        | `-fstack-protector-strong \`                               |
    |               |                        | `-Wformat -Werror=format-security`                         |
    | `CXXFLAGS`    | C++ compiler flags     | `-g -O2 \`                                                 |
    |               |                        | `-fdebug-prefix-map=/build/octave-d7p05X/octave-4.4.1=. \` |
    |               |                        | `-fstack-protector-strong \`                               |
    |               |                        | `-Wformat -Werror=format-security`                         |
    | `FFLAGS`      | Fortran compiler flags | `-g -O2 \`                                                 |
    |               |                        | `-fdebug-prefix-map=/build/octave-d7p05X/octave-4.4.1=. \` |
    |               |                        | `-fstack-protector-strong`                                 |

-   Linker options
    
    | Variable name | Meaning                                  | Default value                                |
    |------------- |---------------------------------------- |-------------------------------------------- |
    | `LFLAGS`      | Path for searching Octave libraries      | `-L/usr/lib/x86_64-linux-gnu/octave/4.4.1 \` |
    |               |                                          | `-L/usr/lib/x86_64-linux-gnu`                |
    | `LIBS`        | Other dependent libraries besides Octave | `-lutil -lm`                                 |
    | `OCTAVE_LIBS` | Octave libraries to be linked with       | `-loctinterp -loctave`                       |
    | `OCTLIBDIR`   | Path to Octave libraries                 | `/usr/lib/x86_64-linux-gnu/octave/4.4.1`     |

To check the current value of the above variables adopted by `mkoctfile`, the option `-p` can be used for the inquiry.
