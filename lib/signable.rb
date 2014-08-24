module Signable
  class << self
    attr_accessor :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end

require "active_support/all"
require "httparty"

require "signable/version"

require "signable/configuration"

require "signable/concerns/prefix"
require "signable/model/column"
require "signable/model/embed"

require "signable/list"

require "signable/concerns/query"
require "signable/concerns/embed"
require "signable/concerns/column"
require "signable/concerns/model"
require "signable/base"

require "signable/query/response"
require "signable/query/client"

require "signable/contact"
require "signable/user"
require "signable/envelope"
require "signable/template"
require "signable/party"
require "signable/field"
require "signable/document"
