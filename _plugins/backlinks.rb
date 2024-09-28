module Jekyll
  module Backlinks
    def backlink(input)
      backlinks = []
      site = @context.registers[:site]
      site.posts.docs.each do |post|
        if post.content.include?(input)
          backlinks << "<a href=\"#{post.url}\">#{post.data['title']}</a>"
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

