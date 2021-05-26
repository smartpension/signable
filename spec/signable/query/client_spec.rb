require "spec_helper"

describe Signable::Query::Client do
  include_context 'when signable is configured'

  subject(:client) { described_class.new }

  describe '#remind' do
    context 'when envelope exists' do
      subject { client.remind('envelopes', '2a81e63c5b497761c60121f279c904a0') }
      
      it 'sends reminder', vcr: 'client/remind/success' do
        response = subject
        
        expect(response).to be_instance_of(Signable::Query::Response)
        expect(response.ok?).to eq true
        expect(response.object["message"]).to eq 'The next signing party for this envelope has been reminded.'
      end
    end

    context 'when envelope does not exist' do
      subject { client.remind('envelopes', 'FINGERPRINT123456789') }

      it 'returns message saying the envelope does not exist.', vcr: 'client/remind/not_found' do
        response = subject
        
        expect(response).to be_instance_of(Signable::Query::Response)
        expect(response.ok?).to eq false
        expect(response.object["message"]).to eq 'The envelope does not exist. Have you used the correct envelope fingerprint?'
      end
    end
  end
end
