# frozen_string_literal: true

shared_examples 'Embed' do
  describe '#find_embed' do
    it 'return first embed which match the name' do
      described_class.embed :match
      described_class.embed :non_match

      object = described_class.new
      expect(object.find_embed('match').name).to eq :match
    end
  end

  describe '.embed' do
    it 'add a new embed to the list of embeds' do
      described_class.embed :foo
      expect(described_class.embeds.last.name).to eq :foo
    end

    it 'automatically add the prefix' do
      described_class.embed :foo

      expect(described_class.embeds.last.prefix).to eq described_class.name.demodulize.underscore
    end
  end
end
