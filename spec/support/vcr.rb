# frozen_string_literal: true

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true

  %w[
    SIGNABLE_API_KEY
  ].each do |variable|
    c.filter_sensitive_data(variable) { ENV.fetch(variable) }
  end
end
