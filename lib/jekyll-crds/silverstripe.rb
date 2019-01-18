module Jekyll
  module Crds
    class Silverstripe < Base

      def import!(name)
        site = scaffold
        client = Jekyll::Crds::Client.new
        begin
          directory = File.join(site.config['source'], '_includes')
          FileUtils.mkdir_p(directory)
          filename = File.join(directory, ActiveSupport::Inflector.underscore("_#{name}") + ".html")
          file = File.open(filename, "w")
          if file.write(client.select(name)['content'])
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
