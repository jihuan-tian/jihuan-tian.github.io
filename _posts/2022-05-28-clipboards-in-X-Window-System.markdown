---
layout: post
title: Clipboards in X Window System
date: 2022-05-28
categories: [computer]
tags: [Bash,Command,Linux,X-Window,Emacs]
mathjax: false
---

There are three types of clipboards in X Window System.

-   Primary selection
    
    It contains the last selection of text via mouse dragging in an X application. Clicking the middle mouse button will paste its contents elsewhere. This is a very convenient way for fast copying and pasting on Linux, since only mouse clicking is needed without bothering to press the `Ctrl+c/Ctrl+v` hotkeys.
-   Secondary selection
    
    It is a counterpart of the primary selection, but most applications do not support it. Luckily, in Emacs we can use this function via mouse clicking similar to the operation for the primary selection, but with the `Meta` key pressed. When some text is selected in this way, Emacs will highlight it using a color different from that for a normal mouse selection, which is controlled by the face `secondary-selection`. By the way, the face for the primary selection in Emacs is `region`.
-   Clipboard
    
    This is the classical clipboard manipulated via the `Ctrl+c/Ctrl+v` hotkeys, which we&rsquo;ve been familiar with in most operating systems.

Linux provides the command `xclip` to directly operate on the three types of clipboards in X Window System. Its option `-selection` is used to specify which clipboard is to be used. Possible values are `primary`, `secondary` and `clipboard`. If `xclip` is further combined with other Linux commands via pipes,

```bash
command | xclip -selection clipboard
```

some tasks frequented in our work can be automated. For example, we can copy the current absolute path into the clipboard as below. Note that the second command in the pipeline is to remove the trailing newline character in the output from `pwd`.

```bash
pwd | tr -d '\n' | xclip -selection clipboard
```

We can also copy the current folder name into the clipboard with the help of `basename`. Its option `-z` ends its output string with `NULL` instead of newline.

```bash
basename -z `pwd` | xclip -selection clipboard
```

Moreover, an image in the clipboard which is acquired by a screen capturing tool, e.g. Spectacle on KDE, can be automatically saved into a file with the current time stamp as the file name. In the following Bash script `cpimg.sh`, I use the option `-t TARGETS -o` of `xclip` to get the type of the content in the clipboard, then make sure it is actually a PNG image by using `grep`. The formatted time stamp is obtained from `date`. The image will be saved into the folder `${default_path}`, which is specified via the command line option `-p`. User can also specify a descriptive file name, which will be appended to the time stamp.

```bash
#!/bin/bash

script_name="cpimg.sh"
script_usage=$(cat <<EOF
$script_name [OPTION] [image-file-name]
EOF
)
script_function=$(cat <<EOF
Save the image in the clipboard to a PNG file. The file name is
optional. The default file name uses the current date and time string.
EOF
)
script_doc=$(cat <<EOF
Script documentation.
-h     Display this help.
-p     Path to the image file, which should end with a slash.
EOF
)
script_examples=$(cat <<EOF
$script_name -p ./figures/ my_image
EOF
)
state_prefix="==="
warning_prefix="***"
error_prefix="!!!"

function display_help() {
    if [ -n "$script_usage" ]; then
        echo -e "Usage: $script_usage"
    fi

    if [ -n "$script_function" ]; then
        echo -e "$script_function"
    fi

    if [ -n "$script_doc" ] ; then
        echo -e "\n$script_doc"
    fi

    if [ -n "$script_examples" ]; then
        echo -e "\nExamples"
        echo -e "$script_examples"
    fi
}

# Default path for the image file.
default_path="./"

# Process command options
while getopts ":hp:" opt; do
    case $opt in
        p  )  default_path=$OPTARG ;;
        h  )  display_help
            exit 0 ;;
        \? )  display_help
            exit 1 ;;
    esac
done
shift $(($OPTIND - 1))

# Check if the path exists.
if [ ! -d "$default_path" ]; then
    echo "$error_prefix The target path does not exist!"
else
    target_type=`xclip -selection clipboard -t TARGETS -o | grep "image/png"`

    if [ -n "$target_type" ]; then
        timestamp=`date +%F_%H-%M-%S`

        # If there is an argument, append it to the default file name.
        if [ $# = "1" ]; then
            file_name="${default_path}${timestamp}-$1.png"
        else
            file_name="${default_path}${timestamp}.png"
        fi

        xclip -selection clipboard -t image/png -o > "$file_name"
    else
        echo "$error_prefix The content in the clipboard cannot be saved as a PNG image!"
    fi
fi
```
