module Signable
  module Concerns
    module Column
      extend ActiveSupport::Concern

      def required_column
        self.class.columns.select(&:required?)
      end

      def find_column(name)
        self.class.columns.find { |column| column.match?(name) }
      end

      module ClassMethods
        def column(name, options = {})
          columns << Signable::Model::Column.new(name, options.merge(prefix: prefix))
        end

        def columns
          @columns ||= []
        end
      end

    end
  end
end
