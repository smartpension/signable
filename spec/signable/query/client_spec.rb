require "spec_helper"

describe Signable::Query::Client do
  subject(:client) do
    dc = described_class.new
      # described_class.define(:cattr_accessor, :foo)
    dc.class.class_variable_set(:@@base_uri, 'api.signable.co.uk')

      # described_class.base_uri = 'api.signable.co.uk'
    dc
  end

  # before do
  #   # allow(described_class).to receive(:base_uri).and_return('api.signable.co.uk')
  #   allow(Signable::Configuration).to receive(:base_url).and_return('api.signable.co.uk')
  # end

  # 'api.signable.co.uk'

  describe '#remind', vcr: {record: :once} do
    # described_class.base_uri =

    subject { client.remind('envelopes', 'FINGERPRINT123456789') }

    it 'calls /remind Signable endpoint' do

      # binding.pry
      expect(subject).to be_instance_of(Signable::Query::Response)
    end
  end

end
