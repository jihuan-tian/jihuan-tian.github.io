---
layout: post
title: Make Eudict textbook for reviewing example sentences
date: 2021-04-04
categories: [thoughts]
tags: [英语学习]
---

Recently, I've started an activity of recording typical and nice English sentences from dictionaries or books to my personal Markdown document. By providing context and hints, this method is quite helpful and has been proved to be effective for remembering newly studied glossaries. In the following source code block, you can see the format of the Markdown document I've adopted.

```
# 03/31/2021

* There isn't much equipment. We're going to have to **improvise**. 设备不多，我们只能临时凑一些。
* We **improvised** several delicacies out of remaining vegetables in the refrigerator. improvise: to make or do sth using whatever is available, usually because you do not have what you really need 临时拼凑；临时做

# 04/01/2021

* He had a practical **outlook** on life. 他的人生观很实际。
* The house has a pleasant **outlook** over the valley. 房子俯瞰山谷，景色宜人。
* She's already **outgrown** her school uniform. 她已经长得连校服都不能穿了。
```

Meanwhile, borrowing the concepts of creating memory chunks and recalling them with irregular repetitions from the book “[A Mind for Numbers](https://book.douban.com/subject/25913349/)” being read, I feel it will be valuable if these sentences can be typeset onto flashcards to implement the said learning methods. Luckily, Eudict, which I'm now using everyday for reciting English words, has already provided such mechanism. The only thing left for me is to transform those Markdown texts to CSV file and uploaded to [Eudict user books](http://my.eudic.net/recite/userbooks). In this post, I'll introduce the procedures.

1. When copying the example sentences from the dictionary into Markdown document, insert double vertical bars wrapped by white spaces “␣||␣” between the original English text and the interpretation, or you can use any separator as you want. Now, the Markdown document looks like this:

```
# 03/31/2021

* There isn't much equipment. We're going to have to **improvise**. || 设备不多，我们只能临时凑一些。
* We **improvised** several delicacies out of remaining vegetables in the refrigerator. || improvise: to make or do sth using whatever is available, usually because you do not have what you really need 临时拼凑；临时做

# 04/01/2021

* He had a practical **outlook** on life. || 他的人生观很实际。
* The house has a pleasant **outlook** over the valley. || 房子俯瞰山谷，景色宜人。
* She's already **outgrown** her school uniform. || 她已经长得连校服都不能穿了。
```

2. Export the Markdown document into an HTML file.

3. Paste the contents in the HTML file into LibreOffice Calc as “Unformatted text”, during which, in the “Text import” dialogue, enable “Merge delimiters” option, select “Separated by” “Other” and input the vertical bar “|” as the separator, and ensure the “Text delimiter” field is empty.

![](/figures/p80949417.jpg)

4. After pasting the sentences, replace the leading white spaces with null, which may exist at the front of each interpretation. The white spaces can be matched by using the regular expression ^\\s\*.

![](/figures/p80949418.jpg)

5. Delete all rows containing calendar dates.

6. Select and copy all the processed contents into a simple text file. On my Linux system, I prefer Kate editor.

7. In the text file, first replace all the English commas with Chinese commas, which is suggested by Eudict, because the English comma will be used as field delimiter. Then replace all TAB characters with English commas.

8. Save the text file using UTF-8 encoding.

9. Upload the text file to [Eudict user books](http://my.eudic.net/recite/userbooks) and you can see your imported sentences.

![](/figures/p80949419.jpg)

10. Click the “下载” link on your defined dictionary book and scan the 2D barcode in Eudict APP to download.

![](/figures/p80949423.jpg)

Now, you can enjoy your repetitive study using Eudict flashcards according to the forgetting curve.

{{ 2021-04-04-Make Eudict textbook for reviewing example sentences | backlink }}
