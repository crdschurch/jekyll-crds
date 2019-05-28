module Jekyll
  module ContentFilter

    def content(obj)
      return obj.content if obj.content.present?
      return obj['body'] if obj['body'].present?
      obj['description']
    end

  end
end

Liquid::Template.register_filter(Jekyll::ContentFilter)
