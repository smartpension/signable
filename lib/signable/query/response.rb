module Signable
  module Query
    class Response < Struct.new(:http_response)

      def ok?
        [200, 202].include?(http_response.code.to_i)
      end

      def object
        @object ||= JSON.parse(http_response.body)
      end

    end
  end
end
