#!/bin/bash

template=$(cat <<EOF
---
layout: page
title: ${1^}
permalink: /$1/
---

<ul class="post-list">
  {% for post in site.categories.$1 %}
  <li>
    {%- assign date_format = site.minima.date_format | default: "%b %-d, %Y" -%}
    <span class="post-meta">{{ post.date | date: date_format }}</span>
    <h3>
      <a class="post-link" href="{{ post.url | relative_url }}">
        {{ post.title }}
      </a>
    </h3>
  </li>
  {% endfor %}
</ul>
EOF
)

category_page_file="$1".html

if [ -f "$category_page_file" ]; then
    echo "The category page has already existed!"
else
    echo "$template" > "$category_page_file"
fi
