# frozen_string_literal: true

shared_examples 'Column' do
  before do
    described_class.instance_variable_set(:@columns, [])
  end

  describe '#required_column' do
    it 'return required column only' do
      described_class.column :required, presence: true
      described_class.column :non_required

      object = described_class.new
      expect(object.required_column.length).to eq 1
      expect(object.required_column.first.name).to eq :required
    end
  end

  describe '#find_column' do
    it 'return first column which match the name' do
      described_class.column :match
      described_class.column :non_match

      object = described_class.new
      expect(object.find_column('match').name).to eq :match
    end
  end

  describe '.column' do
    it 'add a new column to the list of columns' do
      described_class.column :foo
      expect(described_class.columns.last.name).to eq :foo
    end

    it 'automatically add the prefix' do
      described_class.column :foo

      expect(described_class.columns.last.prefix).to eq described_class.name.demodulize.underscore
    end
  end
end
