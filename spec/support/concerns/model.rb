Signable::Embedded = Struct.new(:arg)

shared_examples 'Model' do

  it_behaves_like 'Column'
  it_behaves_like 'Embed'

  describe "#attributes" do
    it "set attributes specified by column" do
      described_class.column :foo
      object = described_class.new foo: 'bar'
      expect(object.foo).to be_eql 'bar'
    end

    it "set object specified by embed" do
      described_class.embed :embeddeds
      object = described_class.new embeddeds: ['bar']
      expect(object.embeddeds.first.arg).to be_eql 'bar'
    end
  end

  describe "#valid?" do
    subject { described.valid? }

    before do
      described_class.column :required, presence: true
    end

    context "when all required fields are present" do
      let (:described) { described_class.new required: 'test' }

      it { should be true }
    end

    context "when all required fields are not present" do
      let (:described) { described_class.new }
      it { should be false }
    end
  end

  describe ".prefix" do
    subject { described_class.prefix }

    it { should be_eql described_class.name.demodulize.underscore }
  end
end
