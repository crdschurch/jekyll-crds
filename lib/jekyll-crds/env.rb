
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
        @site.config['gateway_server_endpoint'] = "https://gateway#{env_prefix}.crossroads.net/gateway/"
        @site.config['imgix'] = {
          "find": ENV['IMGIX_SRC'],
          "replace": ENV['IMGIX_DOMAIN'],
        }
        @site.config['default_image'] = "//#{ENV['IMGIX_DOMAIN']}/default-image.jpg"
        configure_shared_header
        configure_streamspot_credentials
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

        def configure_streamspot_credentials
          @site.config['streamspotId'] = ENV['STREAMSPOT_ID']
          @site.config['streamspotKey'] = ENV['STREAMSPOT_API_KEY']
          @site.config['streamspotPlayerId'] = ENV['STREAMSPOT_PLAYER_ID']
        end

    end
  end
end
