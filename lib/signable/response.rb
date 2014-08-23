module Signable
  class Response < Struct.new(:http_response)

    def ok?
      http_response.code.to_i == 200
    end

    def object
      @object ||= JSON.parse(http_response.body)
    end
  end
end
