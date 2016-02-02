require "spec_helper"

RSpec.describe Doctor::Dto::HdResultDto do

  subject do
    described_class.new(params)
  end

  context "Check visibility of attributes" do

    let(:params) do
      {status: "ok", error_message: "nil_object", name: "uai_test"}
    end

    it "Does status is public" do
      expect(subject).to respond_to(:status)
    end

    it "Does error_message is private" do
      expect(subject).to_not respond_to(:error_message)
    end

    it "Does name is private" do
      expect(subject).to_not respond_to(:name)
    end

  end
end
