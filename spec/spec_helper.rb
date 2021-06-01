require 'rspec'
require "signable"
require "support/vcr"
require "support/webmock"
require 'pry'

Dir.glob("#{File.dirname(__FILE__)}/support/**/*.rb").each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec

  config.around(:each, :vcr) do |example|
    VCR.use_cassette(*example.metadata[:vcr]) { example.call }
  end
end
