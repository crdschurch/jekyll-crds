module Jekyll
  module GetDocFilter

    def get_doc(obj)
      begin
        return nil if obj.nil?
        return get_docs(obj) if obj.is_a?(Array)
        doc = collection_from_obj(obj).detect { |doc| doc.data['id'] == obj['id'] }
        doc ? doc.to_liquid : nil
      rescue
      end
    end

    def get_docs(objs)
      begin
        return nil if objs.nil?
        return get_doc(objs) unless objs.is_a?(Array)
        ids = objs.collect { |obj| obj['id'] }

        docs = objs.collect do |obj|
          collection_from_obj(obj).select {|doc| ids.include?(doc.data['id']) }
        end
        docs.flatten.uniq.map(&:to_liquid)
      rescue
      end
    end

    private

      def site
        @site ||= site = Jekyll.sites.first
      end

      def collection_from_obj(obj)
        begin
          return [] if obj.nil?
          site.collections[obj['content_type'].pluralize].docs
        rescue
          []
        end
      end

  end
end

Liquid::Template.register_filter(Jekyll::GetDocFilter)
