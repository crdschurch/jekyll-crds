require 'active_support/all'

module Jekyll
  module MetaFilters

    def meta_title(page)

      return page['meta']['title'] if page.to_h.dig('meta', 'title').present?

      unless (system_page_title = match_system_page(page['url'], 'title')).nil?
        return system_page_title
      end

      page_title = page['title']
      site_title = site.config['title']
      return "#{escape(page_title)} | #{escape(site_title)}" if page_title && page_title != site_title
      escape(site_title)
    end

    def meta_description(page)
      return page['meta']['description'] if page.to_h.dig('meta', 'description').present?

      unless (system_page_description = match_system_page(page['url'], 'description')).nil?
        return system_page_description
      end

      attrs = %w{lead description body}
      desc = attrs.map { |a| page[a].try(:strip) }.reject(&:blank?).first || site.config['description']
      html = markdownify(desc)
      text = strip_html(html).remove("\n")
      truncate(text, 160)
    end

    def meta_image(page)
      return "https:#{page['meta']['image']['url']}" if page.to_h.dig('meta', 'image', 'url').present?

      unless (system_page_image = match_system_page(page['url'], 'image')).nil?
        return imgix(system_page_image['url'])
      end

      image_url = imgix(page.to_h.dig('image', 'url')) || site.config['image']
      "https:#{escape(image_url)}"
    end

    private

    def match_system_page(url, field)
      if(system_page = site.collections['system_pages'].docs.detect { |e| e.data['url'].chomp('/') == check_for_root(url).chomp('/') })
        system_page[field] if system_page[field].present?
      end
    end

    def check_for_root(url)
      # crds-net and crds-media both have a / page
      # this will use the /media system page when crds-media evaluates it's own landing page
      url == "/" ? url = "/media" : url
    end

  end
end

Liquid::Template.register_filter(Jekyll::MetaFilters)
