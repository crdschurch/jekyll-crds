require 'pry'

module Jekyll
  module Related
    def related(obj, site, n=3)
      tags = obj['tags'].collect{|a| a['slug']}
      related = []

      unless tags.empty?
        site['articles'].reverse.each do |article|
          # Skip recommended media if it matches article
          if obj['recommended_media'].present? && obj['recommended_media']['id'] == article.data['contentful_id']
            next
          end

          # Skip obj if it matches article
          if obj['id'] && article.id != obj['id']
            unless (tags & article['tags'].collect{|a| a['slug']}).empty?
              related.push(article)
            end
          end

          # Break loop when we reach n entries
          break if related.count == n
        end
      end

      # If related is empty, return n articles, else return related
      if related.empty?
        site['articles'].reverse.take(n)
      else
        related + site['articles'].reverse.take(n - related.length)
      end
    end

  end
end

Liquid::Template.register_filter(Jekyll::Related)
