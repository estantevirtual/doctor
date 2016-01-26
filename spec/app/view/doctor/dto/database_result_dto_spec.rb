require "spec_helper"

RSpec.describe Doctor::Dto::DatabaseResultDto do

  subject do
    described_class.new(params)
  end

  context "Check encapsulation of params" do
    
    let(:params) do
      {status: "ok", error_message: "nil_object", active_record: "uai_test"}
    end
    
    it "Does check if status is public" do
      expect(subject).to respond_to(:status)
    end
    
    it "Does check if error_message is not public" do
      expect(subject).to_not respond_to(:error_message)
    end
    
    it "Does check if active_record is not public" do
      expect(subject).to_not respond_to(:active_record)
    end
    
  end
end
