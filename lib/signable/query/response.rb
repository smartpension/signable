# frozen_string_literal: true

module Signable
  module Query
    Response = Struct.new(:http_response) do
      def ok?
        [200, 202].include?(http_response.code.to_i)
      end

      def object
        @object ||= JSON.parse(http_response.body)
      end
    end
  end
end
