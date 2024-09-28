module Jekyll
  module Backlinks
    # Generate backlinks which point to the URL in @p input. N.B. The URL is
    # inserted in a Jekyll post with the Liquid grammar i.e. {% post_url
    # <input> }, where @p input is the file name (without extension) for the
    # target post.
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

