require 'active_support/inflector'

module Jekyll
  module Commands
    class ExternalJavascripts < Command
      class << self


        def init_with_program(prog)
          prog.command(:external_js) do |c|
            c.syntax "external_js [options]"
            c.description 'Imports data from external 3rd parties'
            c.action do |args, options|
              site = Jekyll::Crds::Utils.scaffold(args)
              Jekyll::Crds::ExternalJavascripts.new(site)
            end
          end
        end

      end
    end
  end
end