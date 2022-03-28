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
