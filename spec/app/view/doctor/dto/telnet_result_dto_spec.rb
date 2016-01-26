require "spec_helper"

RSpec.describe Doctor::Dto::TelnetResultDto do

  subject do
    described_class.new(params)
  end

  context "Check encapsulation of params" do

    let(:params) do
      {
        name: "uai",
        host: "uaigebert.com",
        port: 80,
        timeout: 10,
        wait_time: 5,
        status: "ok",
        error_message: "failed"
      }
    end

    it "Does check if status is public" do
      expect(subject).to respond_to(:status)
    end

    it "Does check if name is not public" do
      expect(subject).to_not respond_to(:name)
    end

    it "Does check if host is not public" do
      expect(subject).to_not respond_to(:host)
    end

    it "Does check if port is not public" do
      expect(subject).to_not respond_to(:port)
    end

    it "Does check if timeout is not public" do
      expect(subject).to_not respond_to(:timeout)
    end

    it "Does check if wait_time is not public" do
      expect(subject).to_not respond_to(:wait_time)
    end
    
    it "Does check if error_message is not public" do
      expect(subject).to_not respond_to(:error_message)
    end

  end
end
