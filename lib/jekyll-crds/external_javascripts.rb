require 'curb'

module Jekyll
  module Crds
    class ExternalJavascripts

      def initialize(site)

        js = [
          'https://js.hs-scripts.com/3993985.js',
          'https://js.hsadspixel.net/fb.js'
        ]

        payload = js.collect do |url|
          Curl::Easy.perform(url).body_str
        end


        path = File.join(site.config['source'], '_assets', 'javascripts', 'vendor', 'external_js.js')
        output = File.new(path, 'w')
        output.write(payload.join("\n\n"))
        output.close
      end

    end
  end
end