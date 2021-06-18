# frozen_string_literal: true

require 'spec_helper'

describe Signable::Model::Column do
  it_behaves_like 'Prefix'

  describe '#required?' do
    subject { column.required? }

    context 'when presence is true' do
      let(:column) { described_class.new('name', presence: true) }

      it { is_expected.to eq true }
    end

    context 'when presence is false' do
      let(:column) { described_class.new('name', presence: false) }

      it { is_expected.to eq false }
    end
  end
end
