module Jekyll
  module Crds
    class Header < Silverstripe
      def process!
        import!('sharedGlobalHeader')
      end
    end
  end
end
