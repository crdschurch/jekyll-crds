module Jekyll
  module Youtube_id
    def youtube_id(url)
      regex = /(?:youtube(?:-nocookie)?\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})/
      match = regex.match(url)
      if match && !match[1].nil?
        match[1]
      else
        nil
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::Youtube_id)
