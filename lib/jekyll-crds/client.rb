require 'httparty'

module Jekyll
  module Crds
    class Client
      include HTTParty
      base_uri ENV['CRDS_CMS_ENDPOINT'] || 'https://content.crossroads.net/'
      attr_accessor :content_blocks

      def initialize
        @options = {}
      end

      def select(title)
        content_blocks.detect{|b| b['title'] == title }
      end

      private

        def content_blocks
          @content_blocks ||= self.class.get("/api/contentblock?category[]=common", @options).dig('contentblocks')
        end
    end
  end
end
