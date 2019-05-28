require 'pry'

module Jekyll
  module Pry
    def pry(obj)
      binding.pry
    end
  end
end

Liquid::Template.register_filter(Jekyll::Pry)
