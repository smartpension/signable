# frozen_string_literal: true

shared_examples 'Prefix' do
  let(:described) { described_class.new 'test', { prefix: 'prefix' } }

  describe '#match?' do
    subject { described.match?(name) }

    context 'when name match name with prefix' do
      let(:name) { 'prefix_test' }

      it { is_expected.to be true }
    end

    context 'when name match name without prefix' do
      let(:name) { 'test' }

      it { is_expected.to be true }
    end

    context 'when name do not match' do
      let(:name) { 'something' }

      it { is_expected.to be false }
    end
  end

  describe '#name_with_prefix' do
    subject { described.name_with_prefix }

    it { is_expected.to be_eql 'prefix_test' }
  end

  describe '#prefix' do
    subject { described.prefix }

    it { is_expected.to be_eql 'prefix' }
  end

  describe '#name_without_prefix' do
    subject { described.name_without_prefix }

    let(:described) { described_class.new 'prefix_test', { prefix: 'prefix' } }

    it { is_expected.to be_eql 'test' }
  end
end
