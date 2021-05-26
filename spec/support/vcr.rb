# frozen_string_literal: true

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true

  c.filter_sensitive_data('Bearer <OAUTH_TOKEN>') do |interaction|
    interaction.request.headers['Authorization']&.first
  end
end
