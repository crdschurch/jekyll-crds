require 'active_support/inflector'

module Jekyll
  module Commands
    class Crds < Command
      class << self

        def init_with_program(prog)
          prog.command(:crds) do |c|
            c.syntax "crds [options]"
            c.description 'Imports data from Silverstripe'
            c.action do |args, options|
              Jekyll::Commands::Crds.process!(args, options)
            end
          end
        end

        def process!(args, options)
          site = Jekyll::Crds::Utils.scaffold(args)
          client = Jekyll::Crds::Client.new
          %w(sharedGlobalHeader footer).each do |title|
            begin
              directory = File.join(site.config['source'], '_includes')
              FileUtils.mkdir_p(directory)
              filename = File.join(directory, ActiveSupport::Inflector.underscore("_#{title}") + ".html")
              file = File.open(filename, "w")
              if file.write(client.select(title)['content'])
                Jekyll.logger.info "#{filename} imported"
              end
            rescue IOError => e
              Jekyll.logger.error "There was a problem importing: #{filename}"
            ensure
              file.close unless file.nil?
            end
          end
        end

      end
    end
  end
end
