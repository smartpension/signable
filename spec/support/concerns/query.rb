# frozen_string_literal: true

shared_examples 'Query' do
  before do
    described_class.instance_variable_set(:@columns, [])
    described_class.column :id
  end

  let(:response) { instance_double(Signable::Query::Response, 'response', ok?: false) }

  describe '#save' do
    context 'when persisted' do
      let(:described) { described_class.new id: 1 }

      it 'call client update' do
        expect(described_class.client).to receive(:update).with(described_class.entry_point, 1,
                                                                described).and_return response
        described.save
      end
    end

    context 'when not persisted' do
      let(:described) { described_class.new }

      it 'call client create' do
        expect(described_class.client).to receive(:create).with(described_class.entry_point,
                                                                described).and_return response
        described.save
      end
    end
  end

  describe '#delete' do
    let(:described) { described_class.new id: 1 }

    it 'call client delete' do
      expect(described_class.client).to receive(:delete).with(described_class.entry_point,
                                                              described.id).and_return response
      described.delete
    end
  end

  describe '#persisted?' do
    subject { described.persisted? }

    let(:described) { described_class.new }

    context 'when id is nil' do
      it { is_expected.to eq false }
    end

    context 'when id is present' do
      before do
        described.id = 1
      end

      it { is_expected.to eq true }
    end
  end

  describe '.all' do
    it 'call client all with default value for offset and limit' do
      expect(described_class.client).to receive(:all).with(described_class.entry_point, 0, 30).and_return response
      described_class.all
    end
  end

  describe '.find' do
    it 'call client find' do
      expect(described_class.client).to receive(:find).with(described_class.entry_point, 1).and_return response
      described_class.find 1
    end
  end
end
