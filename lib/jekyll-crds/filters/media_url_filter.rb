module Jekyll
  module MediaUrlFilter

    def media_url(item, arg = nil)
      unless item.nil? 
        item["bitmovin_url"].nil? || !(item["related_videos"] && item["related_videos"].select { |video| video["bitmovin_url"] }.length > 0) ? item.url : append_video_params(item, arg)
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
