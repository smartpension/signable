Signable::Embedded = Struct.new(:arg) do

  def form_data
    "embedded"
  end

end

shared_examples 'Model' do

  it_behaves_like 'Column'
  it_behaves_like 'Embed'

  before do
    described_class.instance_variable_set(:@columns, [])
  end

  describe "#attributes" do
    it "sets attributes specified by column" do
      described_class.column :foo
      object = described_class.new foo: 'bar'
      expect(object.foo).to be_eql 'bar'
    end

    it "responds to attributes specified by column" do
      described_class.column :foo
      object = described_class.new foo: 'bar'
      expect(object.respond_to?(:foo)).to be true
    end

    it "sets object specified by embed" do
      described_class.embed :embeddeds
      object = described_class.new embeddeds: ['bar']
      expect(object.embeddeds.first.arg).to be_eql 'bar'
    end

    it "responds to attributes specified by embed" do
      described_class.column :foo
      object = described_class.new foo: 'bar'
      expect(object.respond_to?(:foo)).to be true
    end

    it "does not respond to missing attributes" do
      described_class.column :foo
      object = described_class.new foo: 'bar'
      expect(object.respond_to?(:bar)).to be false
    end
  end

  describe '#form_data' do
    subject { described.form_data }

    context 'when attribute is a column' do
      let(:described) { described_class.new foo: 'bar' }

      before do
        described_class.column :foo
      end

      it { should be_eql({ "base_foo" => "bar" }) }
    end

    context 'when attribute is an embed' do
      let(:described) { described_class.new embeddeds: ['bar'] }

      before do
        described_class.embed :embeddeds
      end

      it { should be_eql({ "base_embeddeds" => ["embedded"] }) }
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
