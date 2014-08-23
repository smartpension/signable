require "spec_helper"

describe Signable::Embed do

  it_behaves_like 'Prefix'

  describe "#embed_class" do
    let(:column) { Signable::Embed.new('embeds') }

    subject { column.embed_class }

    it { should be Signable::Embed }
  end

end
