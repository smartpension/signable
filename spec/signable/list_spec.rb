require "spec_helper"

DataType = Struct.new(:hash)

describe Signable::List do

  let(:hash) {{ 'offset' => 5, 'limit' => 12, 'total_data_types' => 2, 'data_types' => [{},{}] }}
  let(:list) { Signable::List.new(DataType, hash) }

  describe "#offset" do
    subject { list.offset }

    it { should be 5 }
  end

  describe "#limit" do
    subject { list.limit }

    it { should be 12 }
  end

  describe "#total" do
    subject { list.total }

    it { should be 2 }
  end

  describe "#data" do
    context "length" do
      subject { list.data.length }
      it { should be 2 }
    end

    context "class name" do
      subject { list.data.first.class.name }
      it { should be_eql 'DataType' }
    end
  end

end
