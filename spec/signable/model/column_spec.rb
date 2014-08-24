require "spec_helper"

describe Signable::Model::Column do

  it_behaves_like 'Prefix'

  describe "#required?" do
    subject { column.required? }
    context "when presence is true" do
      let(:column) { Signable::Model::Column.new('name', presence: true) }
      it { should be true }
    end

    context "when presence is false" do
      let(:column) { Signable::Model::Column.new('name', presence: false) }
      it { should be false }
    end
  end

end
