module Jekyll
  module AltFilter
    def alt(input)
      if input.present?
        id = input.is_a?(String) ? input : input.dig('id')
        path = File.join(site.collections_path, "_assets", "#{id}.md")
        obj = YAML.load(File.read(path))
        (obj.dig('description') || obj.dig('title') || nil) unless obj.nil? || obj.is_a?(String)
      end
    end
  end

end

Liquid::Template.register_filter(Jekyll::AltFilter)