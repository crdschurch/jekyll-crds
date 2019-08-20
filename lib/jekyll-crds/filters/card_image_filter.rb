module Jekyll
  module CardImageFilter
    def card_image(doc)
      item = doc.instance_variable_get('@obj').try('data')
      case item.dig('content_type')
      when 'song', 'album'
        item.dig('bg_image', 'url')
      when 'message'
        item.dig('background_image', 'url')
      when 'episode'
        item.dig('podcast', 'bg_image', 'url')
      else
        item.dig('image', 'url')
      end
    rescue
    end
  end
end

Liquid::Template.register_filter(Jekyll::CardImageFilter)