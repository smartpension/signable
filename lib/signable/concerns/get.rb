module Signable
  module Concerns
    module Get

      def get(entry_point, params = {})
        uri = get_uri(entry_point, params)

        https = build_https(uri)
        request = Net::HTTP::Get.new(uri.request_uri)

        execute(https, request)
      end

      private

      def get_uri(entry_point, params)
        path = path(entry_point)
        path_and_params = path_and_params(path, params)
        URI.parse("#{protocol}#{base_url}#{path_and_params}")
      end

      def path_and_params(path, hash = {})
        query_params = hash.map do |key, value|
          if value.is_a? Hash
            "#{escape(key)}=#{escape(value.to_json)}"
          else
            "#{escape(key)}=#{escape(value)}"
          end
        end

        path + '?' + query_params.flatten.join('&')
      end

      def escape(value)
        CGI.escape value.to_s
      end

    end
  end
end
