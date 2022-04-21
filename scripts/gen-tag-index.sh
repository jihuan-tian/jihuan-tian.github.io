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
