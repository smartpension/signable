require "spec_helper"

describe Signable::Query::Response do

  describe "#ok?" do
    let(:response) { Signable::Query::Response.new http_response }
    subject { response.ok? }

    context "when code is 200" do
      let(:http_response) { double 'http_response', code: 200 }
      it { should be true }
    end

    context "when code is 202" do
      let(:http_response) { double 'http_response', code: 202 }
      it { should be true }
    end

    context "when code is !200" do
      let(:http_response) { double 'http_response', code: 205 }
      it { should be false }
    end
  end

  describe "#object" do
    let(:http_response) { double 'http_response', body: { bar: 'foo' }.to_json }

    it "parse body response" do
      response = Signable::Query::Response.new http_response
      expect(response.object).to be_eql({ 'bar' => 'foo' })
    end
  end

end
