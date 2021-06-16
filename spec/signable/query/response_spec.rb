# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable RSpec/VerifiedDoubles
describe Signable::Query::Response do
  describe '#ok?' do
    subject { response.ok? }

    let(:response) { described_class.new http_response }

    context 'when code is 200' do
      let(:http_response) { double code: 200 }

      it { is_expected.to be true }
    end

    context 'when code is 202' do
      let(:http_response) { double code: 202 }

      it { is_expected.to be true }
    end

    context 'when code is !200' do
      let(:http_response) { double code: 205 }

      it { is_expected.to be false }
    end
  end

  describe '#object' do
    let(:http_response) { double body: { bar: 'foo' }.to_json }

    it 'parse body response' do
      response = described_class.new http_response
      expect(response.object).to be_eql({ 'bar' => 'foo' })
    end
  end
end
# rubocop:enable RSpec/VerifiedDoubles
