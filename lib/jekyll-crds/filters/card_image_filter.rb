module Jekyll
  module CardImageFilter
    def card_image(doc)
      item = doc.instance_variable_get('@obj').try('data')
      case item.dig('content_type')
      when 'song', 'album', 'message', 'episode'
        item.dig('background_image', 'url') || item.dig('bg_image', 'url') || item.dig('image', 'url')
      else
        item.dig('image', 'url')
      end
    rescue
    end
  end
end

Liquid::Template.register_filter(Jekyll::CardImageFilter)