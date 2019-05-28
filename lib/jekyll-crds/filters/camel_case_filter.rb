=begin
 # Custom to camelcase function
 # Usage:
 #   'string'.camelize
 #   'string'.camelize(:lower)
=end
module Jekyll
    module Camelcase
        def camelcase(str)
            str.split('-').map{|e| e.capitalize}.join
        end
    end
end

Liquid::Template.register_filter(Jekyll::Camelcase)
