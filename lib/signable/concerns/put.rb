module Signable
  module Concerns
    module Put

      def put(entry_point, object)
        uri = uri(entry_point)

        https = build_https(uri)
        request = Net::HTTP::Put.new(uri.request_uri)
        request.set_form_data(object.form_data)

        execute(https, request)
      end

    end
  end
end
