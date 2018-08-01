module Jekyll
  module Crds
    class EnvGenerator < Generator

      def generate(site)
        Jekyll::Crds::Env.new(site)
      end

    end
  end
end
