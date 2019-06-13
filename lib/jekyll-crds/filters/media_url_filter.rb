module Jekyll
  module MediaUrlFilter

    def media_url(item, arg = nil)
      unless item.nil? 
        item["bitmovin_url"] || (item["related_videos"] && item["related_videos"][0]["bitmovin_url"]) ? append_video_params(item, arg) : item.url 
      end
    end

    def append_video_params(item, arg)
      if arg.present?
        "#{item.url}?#{arg}"
      else
        "#{item.url}?autoPlay=true&sound=11"
      end
    end
  end
  
end

Liquid::Template.register_filter(Jekyll::MediaUrlFilter)
