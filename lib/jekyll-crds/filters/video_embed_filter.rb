class EmbeddableVideo
  def initialize(video)
    @contentful_id = video['contentful_id']
    @video = EmbeddableVideo.parse_video_url(video['source_url'])
  end

  def to_s
    if @video
      transcript = @video['transcript']
      if @video[:provider] == 'youtube'
        embed_url = "https://www.youtube.com/embed/#{@video[:id]}"
      elsif video[:provider] == 'vimeo'
        embed_url = "https://player.vimeo.com/video/#{@video[:id]}"
      end
      tpl.result(binding)
    end
  end

  def tpl
    ERB.new File.read(File.join(__dir__, '../templates/video_embed.html.erb'))
  end

  def self.parse_video_url(url)
    @url = url
    youtube_formats = [
        %r(https?://youtu\.be/(.+)),
        %r(https?://www\.youtube\.com/watch\?v=(.*?)(&|#|$)),
        %r(https?://www\.youtube\.com/embed/(.*?)(\?|$)),
        %r(https?://www\.youtube\.com/v/(.*?)(#|\?|$)),
        %r(https?://www\.youtube\.com/user/.*?#\w/\w/\w/\w/(.+)\b)
      ]
    vimeo_formats = [%r(https?://vimeo.com\/(\d+)), %r(https?:\/\/(www\.)?vimeo.com\/(\d+))]
    @url.strip!
    if @url.include? "youtu"
      youtube_formats.find { |format| @url =~ format } and $1
      @results = {provider: "youtube", id: $1}
      @results
    elsif @url.include? "vimeo"
      vimeo_formats.find { |format| @url =~ format } and $1
      @results = {provider: "vimeo", id: $1}
      @results
    else
      return nil # There should probably be some error message here
    end
  end
end

module Jekyll
  module VideoEmbedFilter
    def video(obj)
      EmbeddableVideo.new(obj).to_s
    end
  end
end

Liquid::Template.register_filter(Jekyll::VideoEmbedFilter)
