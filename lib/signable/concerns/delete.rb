module Signable
  module Concerns
    module Delete

      def delete(entry_point)
        uri = uri(entry_point)

        https = build_https(uri)
        request = Net::HTTP::Delete.new(uri.request_uri)

        execute(https, request)
      end

    end
  end
end
