module Signable
  module Query
    class Client
      include HTTParty

      def initialize
        self.class.base_uri "https://#{Signable.configuration.base_url}/v1"
        self.class.basic_auth Signable.configuration.api_key, ''
        self.class.default_options[:verify] = false
      end

      def all(entry_point, offset, limit)
        response = self.class.get "/#{entry_point}", query: { offset: offset, limit: limit }
        Response.new response
      end

      def find(entry_point, id)
        response = self.class.get "/#{entry_point}/#{id}"
        Response.new response
      end

      def update(entry_point, id, object)
        response = self.class.put "/#{entry_point}/#{id}", body: object.form_data
        Response.new response
      end

      def create(entry_point, object)
        response = self.class.post "/#{entry_point}", body: object.form_data
        Response.new response
      end

      def delete(entry_poind, id)
        response = self.class.delete "/#{entry_point}/#{id}"
        Response.new response
      end

    end
  end
end
