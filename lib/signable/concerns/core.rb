module Signable
  module Concerns
    module Core

      def execute(https, request)
        request.basic_auth(api_key, "")
        Response.new https.request(request)
      end

      def build_https(uri)
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true
        https.verify_mode = OpenSSL::SSL::VERIFY_NONE
        https
      end

      def path(entry_point)
        "/v1/#{entry_point}"
      end

      def protocol
        'https://'
      end

      def uri(entry_point)
        path = path(entry_point)
        URI.parse("#{protocol}#{base_url}#{path}")
      end

    end
  end
end
