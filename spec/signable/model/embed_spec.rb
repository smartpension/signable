# frozen_string_literal: true

require 'spec_helper'

describe Signable::Model::Embed do
  it_behaves_like 'Prefix'

  describe '#embed_class' do
    subject { column.embed_class }

    let(:column) { described_class.new('contacts') }

    it { is_expected.to eq Signable::Contact }
  end
end
