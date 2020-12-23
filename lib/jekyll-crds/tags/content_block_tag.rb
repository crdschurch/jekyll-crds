module Jekyll
  class ContentBlockTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @text = text.strip
    end

    def render(context)
      site = context.registers[:site]
      if site.collections['content_blocks'] &&
         (content_block = site.collections['content_blocks'].docs.detect{|b| b.data['slug'] == @text})
         markdownify content_block.data.dig('content'), site
      end
    end

    def markdownify(input, site)
      site.find_converter_instance(
        Jekyll::Converters::Markdown
      ).convert(input.to_s)
    end
  end
end

Liquid::Template.register_tag('content_block', Jekyll::ContentBlockTag)