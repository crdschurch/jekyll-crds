require 'active_support/all'

module Jekyll
  module MetaFilters

    def meta_title(page)

      return page['meta']['title'] if page.to_h.dig('meta', 'title').present?

      unless (system_page_title = match_system_page(get_url(page), 'title')).nil?
        return system_page_title
      end

      page_title = page['title']
      site_title = site.config['title']
      return "#{escape(page_title)} | #{escape(site_title)}" if page_title && page_title != site_title
      escape(site_title)
    end

    def meta_description(page)
      return page['meta']['description'] if page.to_h.dig('meta', 'description').present?

      system_page_description = match_system_page(get_url(page), 'description')

      if system_page_description.present?
        return system_page_description
      end

      attrs = %w{lead_text lead description body}
      desc = attrs.map { |a| page[a].try(:strip) }.reject(&:blank?).first || site.config['description']
      html = markdownify(desc)
      text = strip_html(html).remove("\n")
      truncate(text, 160)
    end

    def meta_image(page)
      return "https:#{page['meta']['image']['url']}" if page.to_h.dig('meta', 'image', 'url').present?

      unless (system_page_image = match_system_page(get_url(page), 'image')).nil?
        return imgix(system_page_image['url'], site.config)
      end

      image_url = imgix(page.to_h.dig('image', 'url'), site.config) || site.config['image']
      "https:#{escape(image_url)}"
    end

    def get_canonical_host(page)
      return nil if page['distribution_channels'].nil?
      host = page['distribution_channels'].detect { |channel| channel['canonical'].present? }
      return nil unless host.present?
      page['url'].chomp('index.html').prepend(host['site']).prepend('https://')
    end

    private

    def match_system_page(url, field)
      if site.collections['system_pages']
        system_page = site.collections['system_pages'].docs.detect { |e| e.data['url'].chomp('/') == check_for_root(url).chomp('/') }
        if system_page.present? && system_page[field].present?
          system_page[field]
        end
      end
    end

    def check_for_root(url)
      # crds-net and crds-media both have a / page
      # this will use the /media system page when crds-media evaluates it's own landing page
      url == "/" ? url = "/media" : url
    end

    def get_url(page)
      # crds-net will use 'permalink' ; crds-media will use 'url'
      # crds-media does not have a permalink, so it will default to url
      page['permalink'] ? page['permalink'] : page['url']
    end
    
  end
end

Liquid::Template.register_filter(Jekyll::MetaFilters)
