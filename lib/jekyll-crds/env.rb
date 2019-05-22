module Jekyll
  module Crds
    class Env
      attr_accessor :site, :envs

      def initialize(site)
        @site = site
        @envs = {
          development: 'int',
          int: 'int',
          demo: 'demo',
          production: 'www'
        }
        @site.config['jekyll_env'] = ENV['JEKYLL_ENV'] || 'development'
        @site.config['gateway_server_endpoint'] = configure_gateway_endpoint
        @site.config['imgix'] = {
          "find": ENV['IMGIX_SRC'],
          "replace": ENV['IMGIX_DOMAIN'],
        }
        @site.config['default_image'] = "//#{ENV['IMGIX_DOMAIN']}/default-image.jpg"
        @site.config['url'] = ENV['SITE_URL'] if ENV['SITE_URL']
        configure_shared_header
        configure_stream_schedule
      end


      private
        def configure_shared_header
          @site.config['shared_header'] = {
            'app' => File.join(ENV['CRDS_APP_CLIENT_ENDPOINT'] || "https://#{env_prefix}.crossroads.net", ""),
            'cms' => File.join(ENV['CRDS_CMS_SERVER_ENDPOINT'] || "https://#{env_prefix}.crossroads.net/proxy/content/", ""),
            'img' => "https://#{env_prefix}.crossroads.net/proxy/gateway/api/image/profile/",
            'prefix' => "#{env_prefix unless @site.config['jekyll_env'] == 'production' }"
          }
        end

        def env_prefix
          @envs[@site.config['jekyll_env'].to_sym]
        end

        def configure_stream_schedule
          @site.config['stream_schedule_endpoint'] = ENV['STREAM_SCHEDULE_ENDPOINT']
        end

        def configure_gateway_endpoint
          File.join(ENV['CRDS_GATEWAY_ENDPOINT'] || "https://gateway#{env_prefix unless @site.config['jekyll_env'] == 'production' }.crossroads.net/gateway/", "")
        end
    end
  end
end
