module Jekyll
  module FilterFilters

    def filter(collection, attr, value)
      attrs = attr.split('.')
      collection.select do |obj|
        if obj.data[attrs.first].is_a?(Array)
          obj.data[attrs.first].select { |x| x.dig(*attrs[1..-1]) == value }.size > 0
        else
          obj.data.dig(*attrs) == value
        end
      end
    rescue
      binding.pry
    end

  end
end

Liquid::Template.register_filter(Jekyll::FilterFilters)
