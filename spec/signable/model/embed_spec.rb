require "spec_helper"

describe Signable::Model::Embed do

  it_behaves_like 'Prefix'

  describe "#embed_class" do
    let(:column) { Signable::Model::Embed.new('contacts') }

    subject { column.embed_class }

    it { should be Signable::Contact }
  end

end
