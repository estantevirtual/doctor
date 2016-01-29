require "spec_helper"

RSpec.describe Doctor::Dto::TelnetResultDto do

  subject do
    described_class.new(params)
  end

  context "Check visibility of attributes" do

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

    it "Does status is public" do
      expect(subject).to respond_to(:status)
    end

    it "Does name is private" do
      expect(subject).to_not respond_to(:name)
    end

    it "Does host is private" do
      expect(subject).to_not respond_to(:host)
    end

    it "Does port is private" do
      expect(subject).to_not respond_to(:port)
    end

    it "Does timeout is private" do
      expect(subject).to_not respond_to(:timeout)
    end

    it "Does wait_time is private" do
      expect(subject).to_not respond_to(:wait_time)
    end
    
    it "Does error_message is private" do
      expect(subject).to_not respond_to(:error_message)
    end

  end
end
