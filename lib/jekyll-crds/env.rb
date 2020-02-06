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
        @site.config['okta_client_id'] = ENV['OKTA_CLIENT_ID']
        @site.config['okta_oauth_base_url'] = ENV['OKTA_OAUTH_BASE_URL']
        @site.config['crds_gql_endpoint'] = ENV['CRDS_GQL_ENDPOINT']
        @site.config['crds_music_endpoint'] = ENV['CRDS_MUSIC_ENDPOINT']
        @site.config['imgix'] = {
          "find": ENV['IMGIX_SRC'],
          "replace": ENV['IMGIX_DOMAIN'],
        }
        @site.config['default_image'] = "//#{ENV['IMGIX_DOMAIN']}/default-image.jpg"
        @site.config['url'] = ENV['SITE_URL'] if ENV['SITE_URL']
        @site.config['focus_mission_url'] = ENV['CRDS_FOCUS_MISSION'] if ENV['CRDS_FOCUS_MISSION']
        configure_shared_header
        configure_stream_schedule
        configure_bitmovin_license
        configure_envs
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
          @site.config['streamspotKey'] = ENV['STREAMSPOT_API_KEY']
          @site.config['streamspotId'] = ENV['STREAMSPOT_ID']
          @site.config['streamspotPlayerId'] = ENV['STREAMSPOT_PLAYER_ID']
        end

        def configure_bitmovin_license
          @site.config['bitmovin_player_license'] = ENV['BITMOVIN_PLAYER_LICENSE']
          @site.config['bitmovin_analytics_license'] = ENV['BITMOVIN_ANALYTICS_LICENSE']
        end

        def configure_envs
          @site.config['google_api_key'] = ENV['GOOGLE_API_KEY']
        end

        def configure_gateway_endpoint
          File.join(ENV['CRDS_GATEWAY_ENDPOINT'] || "https://gateway#{env_prefix unless @site.config['jekyll_env'] == 'production' }.crossroads.net/gateway/", "")
        end
    end
  end
end
