# frozen_string_literal: true

require 'rspec'
require 'signable'
require 'support/vcr'
require 'support/webmock'
require 'pry'

Dir.glob("#{File.dirname(__FILE__)}/support/**/*.rb").sort.each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec

  config.around(:each, :vcr) do |example|
    VCR.use_cassette(example.metadata[:vcr], re_record_interval: 1.month) { example.call }
  end
end
