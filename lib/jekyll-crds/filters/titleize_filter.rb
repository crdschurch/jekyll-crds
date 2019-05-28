module Jekyll
  module Titleize
    def titleize(words)
      words.nil? ? words : words.send(:titleize)
    end
  end
end

Liquid::Template.register_filter(Jekyll::Titleize)
