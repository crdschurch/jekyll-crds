module Jekyll
  module Crds
    class Footer < Silverstripe
      def process!
        import!('footer')
      end
    end
  end
end
