require 'net/https'
require 'cgi'
require 'uri'

module Signable
  class Client
    include Signable::Concerns::Core
    include Signable::Concerns::Get
    include Signable::Concerns::Post
    include Signable::Concerns::Put
    include Signable::Concerns::Delete

    attr_reader :api_key, :base_url

    def initialize(http = Net::HTTP)
      @base_url = Signable.configuration.base_url
      @api_key  = Signable.configuration.api_key
      @http     = http
    end

    def all(entry_point, offset, limit)
      get entry_point, offset: offset, limit: limit
    end

    def find(entry_point, id)
      get "#{entry_point}/#{id}"
    end

    def update(entry_point, id, object)
      put "#{entry_point}/#{id}", object
    end

    def create(entry_point, object)
      post entry_point, object
    end

    def delete(entry_poind, id)
      delete "#{entry_point}/#{id}"
    end

  end

end
