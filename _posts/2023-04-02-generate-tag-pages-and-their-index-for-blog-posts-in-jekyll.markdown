---
layout: post
title: Generate tag pages and their index for blog posts in Jekyll
date: 2023-04-02
categories: [computer]
tags: [Jekyll,知识联接]
mathjax: false
---

# Generate a tag page containing related blog posts

I use the following Jekyll page template for displaying a list of blog posts assigned with a specific tag.

```text
---
layout: page
title: "Tag: <tag-name>"
exclude: true
---

<div id="archives">
  <div class="archive-group">
    {% capture tag_name %}<tag-name>{% endcapture %}
    <a name="{{ tag_name | slugize }}"></a>
    {% for post in site.tags[tag_name] %}
    <article class="archive-item">
      <h4>
        <a href="{{ site.baseurl }}{{ post.url }}">{{post.title}}</a> &nbsp; 
        {%- assign date_format = site.minima.date_format | default: "%b %-d, %Y" -%}
        <span class="post-meta">{{ post.date | date: date_format }}</span>
      </h4>
    </article>
    {% endfor %}
  </div>
</div>
```

N.B. The `layout` type in the front matter for a tag page should be `page` instead of `post`. If the default navigation menu for the blog is used, which is defined in `<site-source-root>/_includes/header.html` as below, the option `exclude: true` in the front matter is needed to prevent tag pages from appearing as menu items.

```html
<div class="trigger">
  <!-- Comment out the default sorted categories. -->
  {%- for path in page_paths -%}
    {%- assign my_page = site.pages | where: "path", path | first -%}
      {% unless my_page.exclude %}
        {%- if my_page.title -%}
          <a class="page-link" href="{{ my_page.url | relative_url }}">{{ my_page.title | escape }}</a>
        {%- endif -%}
      {% endunless %}
  {%- endfor -%}
</div>
```

In my case, I enforce a fixed order of the categories appearing in the navigation menu, hence the option `exclude: true` is ignored.

```html
<div class="trigger">
  <!-- Enforce a fixed order for my categories. -->
  <a class="page-link" href="/math/">Math</a>
  <a class="page-link" href="/physics/">Physics</a>
  <a class="page-link" href="/computer/">Computer</a>
  <a class="page-link" href="/methodology/">Methodology</a>
  <a class="page-link" href="/thoughts/">Thoughts</a>
  <a class="page-link" href="/tags/">Tags</a>
  <a class="page-link" href="/about/">About</a>
</div>
```

A bash script `gen-tag-pge.sh` is created for generating such tag page, where `<tag-name>` in the above template is replaced with the first Bash command line argument `$1`. The whole multi-line template is redirected to the standard input (`stdin`) of the `cat` command as [here-document](https://en.wikipedia.org/wiki/Here_document), i.e. the text between `<<label` and `label`, where `labbel` is `EOF` here.

```bash
#!/bin/bash

template=$(cat <<EOF
---
layout: page
title: "Tag: $1"
exclude: true
---

<div id="archives">
  <div class="archive-group">
    {% capture tag_name %}$1{% endcapture %}
    <a name="{{ tag_name | slugize }}"></a>
    {% for post in site.tags[tag_name] %}
    <article class="archive-item">
      <h4>
        <a href="{{ site.baseurl }}{{ post.url }}">{{post.title}}</a> &nbsp; 
        {%- assign date_format = site.minima.date_format | default: "%b %-d, %Y" -%}
        <span class="post-meta">{{ post.date | date: date_format }}</span>
      </h4>
    </article>
    {% endfor %}
  </div>
</div>
EOF
)

tag_page_file="$1".html

if [ -f "$tag_page_file" ]; then
    echo "The tag page has already existed!"
else
    echo "$template" > "$tag_page_file"
fi
```

# Generate an index page including all tags

To create an index page including hyperlinks to all the tag pages, I&rsquo;ve written a Bash script as below.

```bash
#!/bin/bash

front_matter=$(cat <<EOF
---
layout: page
title: Tags
permalink: /tags/
---

<div id="archives">
  <div class="archive-group">
    <h4 class="tag-head">
EOF
)

sorted_tag_index=`ls | xargs -I '{}' basename '{}' .html | gawk -f ../scripts/gen-tag-link.awk`

back_matter=$(cat <<EOF
    </h4>
  </div>
</div>
EOF
)

echo "$front_matter" > ../tags.html
echo "$sorted_tag_index" >> ../tags.html
echo "$back_matter" >> ../tags.html
```

Here I use the `ls` command to list all tag HTML pages in the lexicographic order. This will not only order the English tag names but also Chinese tag names according to the phonetic alphabet. Then I use `xargs` to get the base file name of each tag page. Finally, I use an `Awk` script to generate a hyperlink to each tag as well as printing out the number of related blog posts.

```awk
{
  print "      <a href=\""$0"\">"$0"({{ site.tags['"$0"'].size }})</a>"
}
```

{{ "2023-04-02-generate-tag-pages-and-their-index-for-blog-posts-in-jekyll" | backlink }}
