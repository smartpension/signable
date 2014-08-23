require "active_support/all"

require "signable/version"

require "signable/configuration"

require "signable/concerns/prefix"
require "signable/column"
require "signable/embed"

require "signable/list"

require "signable/concerns/query"
require "signable/concerns/embed"
require "signable/concerns/column"
require "signable/concerns/common"
require "signable/base"

require "signable/response"
require "signable/concerns/core"
require "signable/concerns/get"
require "signable/concerns/post"
require "signable/concerns/put"
require "signable/concerns/delete"
require "signable/client"

require "signable/contact"
require "signable/user"
require "signable/envelope"
require "signable/template"
require "signable/party"
require "signable/field"
require "signable/document"

module Signable
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
