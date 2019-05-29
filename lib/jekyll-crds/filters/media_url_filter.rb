module Jekyll
  module MediaUrlFilter

    def media_url(item, arg = nil)
      unless item.nil? 
        item["bitmovin_url"].nil? ? item.url : append_video_params(item, arg)
      end
    end

    def append_video_params(item, arg)
      item.url << "?"
      arg ? item.url << arg : item.url << "autoPlay=true&sound=11"
    end
  end
  
end

Liquid::Template.register_filter(Jekyll::MediaUrlFilter)
