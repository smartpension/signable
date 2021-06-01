# frozen_string_literal: true

RSpec.shared_context 'when signable is configured' do
  Signable.configure do |config|
    config.base_url = 'api.signable.co.uk'
    config.api_key  = ENV['SIGNABLE_API_KEY']
  end
end
