require "spec_helper"

describe Signable::Envelope do
  describe '#update' do
    it 'raises an error' do
      expect { described_class.new.update }.to raise_error('not available')
    end
  end

  describe '#delete' do
    it 'raises an error' do
      expect { described_class.new.delete }.to raise_error('not available')
    end
  end

  describe '#cancel' do
    it 'calls cancel on the Client object passing envelopes endpoint and fingerprint column value' do
      object = described_class.new

      allow(object).to receive(:fingerprint).and_return('FINGERPRINT_COLUMN_VALUE')

      expect(described_class.client).to receive(:cancel).with('envelopes', 'FINGERPRINT_COLUMN_VALUE')

      object.cancel
    end
  end

  describe '#remind' do
    it 'calls remind on the Client object passing envelopes endpoint and fingerprint column value' do
      object = described_class.new

      allow(object).to receive(:fingerprint).and_return('FINGERPRINT_COLUMN_VALUE')

      expect(described_class.client).to receive(:remind).with('envelopes', 'FINGERPRINT_COLUMN_VALUE')

      object.remind
    end
  end
end
