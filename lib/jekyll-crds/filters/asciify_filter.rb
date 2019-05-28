module Jekyll
  module AsciifyFilter

    def asciify(str)
      str.gsub(/[^a-zA-Z0-9\s\.,'"]/, '')
    end

  end
end

Liquid::Template.register_filter(Jekyll::AsciifyFilter)
