module Signable
  module Concerns
    module Model
      extend ActiveSupport::Concern
      include Signable::Concerns::Embed
      include Signable::Concerns::Column

      def initialize(attributes = {})
        @attributes     = HashWithIndifferentAccess.new
        self.attributes = attributes
      end

      def attributes=(attributes = {})
        attributes.each do |key, value|
          if column = find_column(key)
            @attributes[column.name] = value
          elsif embed = find_embed(key)
            values = value.map { |hash| embed.embed_class.new(hash) }
            @attributes[embed.name] = values
          end
        end
      end

      def form_data
        hash = HashWithIndifferentAccess.new

        @attributes.each do |key, value|
          next if key == :id

          if (column = self.find_column(key))
            hash[column.name_with_prefix] = value
          elsif (embed = self.find_embed(key))
            hash[embed.name_with_prefix] = value.map(&:form_data)
          end
        end

        hash
      end

      def method_missing(method, *args, &block)
        get_method = method.to_s.gsub('=', '')
        object = find_column(get_method) || find_embed(get_method)
        if object
          if get_method.to_sym == method
            @attributes[object.name]
          else
            @attributes[object.name] = args.first
          end
        else
          super
        end
      end

      def respond_to_missing?(method, include_private = false)
        get_method = method.to_s.gsub('=', '')
        object = find_column(get_method) || find_embed(get_method)
        object || super
      end

      def valid?
        required_column.all? do |column|
          @attributes[column.name].present?
        end
      end

      module ClassMethods
        def prefix
          name.demodulize.underscore
        end
      end

    end
  end
end
