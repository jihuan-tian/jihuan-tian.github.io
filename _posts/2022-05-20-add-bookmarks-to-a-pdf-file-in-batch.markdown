---
layout: post
title: Add bookmarks to a PDF file in batch
date: 2022-05-20
categories: [computer]
tags: [Emacs,PDF,ImageMagick,OCR]
mathjax: false
---

Under Linux, the tool [JPdfBookmarks](https://sourceforge.net/projects/jpdfbookmarks/) can be use to add a collection of bookmarks to a PDF book in batch by loading information from a text file, which stores the table of contents and page numbers. To prepare this text file manually, I&rsquo;ve summarized the following steps according to my practice for your reference.

1.  Take snapshots of the content pages and save them into images by using `ImageMagick`.
    
    ```bash
    convert -density 300 book.pdf[${page_no}] content_page.png
    ```
    
    Here `${page_no}` should be replaced with the numeric page number of the content page.
2.  Extract text from the image of the content page using the OCR tool [Tesseract](https://github.com/tesseract-ocr/tesseract).
    
    ```bash
    tesseract content_page.png stdout -l eng >> bookmark_text.txt
    ```
    
    The option `stdout` tells `Tesseract` to output the extracted text to standard output and `-l eng` specifies the OCR language as English. To check the list of languages supported by `Tesseract`, execute `tesseract --list-langs`.
    
    ```bash
    $ tesseract --list-langs
    List of available languages (8):
    chi_sim
    chi_sim_vert
    chi_tra
    chi_tra_vert
    deu
    eng
    fra
    osd
    ```
3.  Open the generated text file `bookmark_text.txt` and perform a manual cleaning and reorganization if needed. It is suggested to do this work in Emacs, where the command `regexp-builder` can help us construct and verify regular expressions that are used for efficient text matching and replacement.
4.  Open the target PDF file in `JPdfBookmarks` and load the text file `bookmark_text.txt` by clicking the menu item `Load` in the `Tools` menu.
5.  Check the validity of the PDF page targets associated with those bookmark items and finally save the PDF file.
