---
layout: post
title: "Enable backlinks in Jekyll blog"
date: 2024-09-28
categories: [computer]
tags: [Jekyll]
mathjax: false
---

Enable backlinks by creating a Jekyll filter as below written in Ruby. It should be placed in `$blog/_plugins`.

```ruby
module Jekyll
  module Backlinks
    def backlink(input)
      backlinks = []
      site = @context.registers[:site]
      
      # Iterate over each post in the site.
      site.posts.docs.each do |post|
        # Get the file name of the current post without the extension.
        file_name = File.basename(post.path, File.extname(post.path))

        # When @p file_name contains @p input, we do not add it as a backlink,
        # i.e. a post should not link to itself.
        unless file_name.include?(input)
          if post.content.include?(input)
            backlinks << "<a href=\"#{post.url}\">《#{post.data['title']}》</a>"
          end
        end
      end
      
      if backlinks.any?
        return "Backlinks: #{backlinks.join(', ')}"
      else
        return ""
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::Backlinks)
```

**Note**

-   The URL link passed to the filter function `backlink` is in the original Liquid grammar, not in the HTML format.
-   We should prevent a blog post backlinks to itself.
-   The post URL should be placed between double quotes: {% raw %}`{{ "<post-file-name-without-extension>" | backlink }}`{% endraw %}

{{ "2024-09-28-enable-backlinks-in-jekyll-blog" | backlink }}
