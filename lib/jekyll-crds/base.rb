module Jekyll
  module Crds
    class Base

      private

        def scaffold(args = [])
          @scaffold ||= begin
            app_root = File.expand_path(args.join(" "), Dir.pwd)
            overrides = Jekyll::Configuration.new.read_config_file(File.join(app_root, '_config.yml'))
            site_config = Jekyll::Utils.deep_merge_hashes(Jekyll::Configuration::DEFAULTS, overrides.merge({
              "source" => app_root,
              "destination" => File.join(app_root, '_site')
            }))
            Jekyll::Site.new(site_config)
          end
        end

    end
  end
end
