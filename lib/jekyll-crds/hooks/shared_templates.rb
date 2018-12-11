require 'fileutils'
require "listen"

source_dir = File.join(Gem.loaded_specs['jekyll-crds'].full_gem_path, 'source')

Jekyll::Hooks.register(:site, :after_init) do |site|
  site.includes_load_paths << source_dir
end

Jekyll::Hooks.register(:site, :post_render, priority: :low) do |site|
  if site.config.fetch('watch', false)
    options = site.config
    Jekyll.logger.info "Auto-regeneration:", "enabled for '#{source_dir}'"
    listener = Listen.to(source_dir) do |modified, added, removed|
      layout = File.join site.config.fetch('source'), site.config.fetch('layouts_dir'), 'default.html'
      Jekyll.logger.info "Regenerating:", "Change triggered from jekyll-crds..."
      FileUtils.touch(layout)
    end
    listener.start
  end
end
