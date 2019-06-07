module Jekyll
  module StripFilter
    def strip_liquid(str)
      str.gsub(/({%.+%})/, '');
    end
  end
end

Liquid::Template.register_filter(Jekyll::StripFilter)
