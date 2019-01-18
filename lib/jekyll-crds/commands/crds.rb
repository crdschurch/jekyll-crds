require 'active_support/all'

module Jekyll
  module Commands
    class Crds < Command
      def self.init_with_program(prog)
        prog.command(:crds) do |c|
          c.syntax "crds [options]"
          c.description 'Shared Crossroads utilities for Jekyll projects'

          c.option 'convert_urls', '--convert-urls', 'Scans build directory and replaces production URLs to be environment-specific'
          c.option 'footer', '--shared-footer', 'Retrieve and import shared footer markup'
          c.option 'header', '--shared-header', 'Retrieve and import shared header markup'

          c.action do |args, options|
            options.each do |option, value|
              obj = "Jekyll::Crds::#{option.classify}".constantize.new
              obj.process!
            end
          end
        end
      end
    end
  end
end
