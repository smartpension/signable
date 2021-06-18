# frozen_string_literal: true

require 'spec_helper'

DataType = Struct.new(:data)

describe Signable::List do
  let(:data) { { 'offset' => 5, 'limit' => 12, 'total_data_types' => 2, 'data_types' => [{}, {}] } }
  let(:list) { described_class.new(DataType, data) }

  describe '#offset' do
    subject { list.offset }

    it { is_expected.to eq 5 }
  end

  describe '#limit' do
    subject { list.limit }

    it { is_expected.to eq 12 }
  end

  describe '#total' do
    subject { list.total }

    it { is_expected.to eq 2 }
  end

  describe '#data' do
    describe 'length' do
      subject { list.data.length }

      it { is_expected.to eq 2 }
    end

    describe 'class name' do
      subject { list.data.first.class.name }

      it { is_expected.to eq 'DataType' }
    end
  end
end
