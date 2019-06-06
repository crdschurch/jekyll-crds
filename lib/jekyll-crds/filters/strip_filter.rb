module Jekyll
  module StripFilter
    def strip_liquid(string)
      string.gsub!(/{(.+)}/, '');
    end
  end
end

Liquid::Template.register_filter(Jekyll::StripFilter)
