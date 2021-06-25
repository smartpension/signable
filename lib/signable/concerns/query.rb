# frozen_string_literal: true

module Signable
  module Concerns
    module Query
      extend ActiveSupport::Concern

      def save
        return false unless valid?

        persisted? ? update : create
      end

      def delete
        self.class.client.delete self.class.entry_point, id
      end

      def persisted?
        id.present?
      rescue StandardError
        false
      end

      private

      def update
        response = self.class.client.update self.class.entry_point, id, self
        response.ok?
      end

      def create
        response = self.class.client.create self.class.entry_point, self
        if response.ok?
          self.attributes = response.object
          true
        else
          false
        end
      end

      module ClassMethods
        def all(offset: 0, limit: 30)
          response = client.all(entry_point, offset, limit)

          if response.ok?
            List.new(self, response.object)
          else
            []
          end
        end

        def find(id)
          response = client.find(entry_point, id)

          new response.object if response.ok?
        end

        def entry_point
          prefix.pluralize
        end

        def client
          @client ||= Signable::Query::Client.new
        end
      end
    end
  end
end
