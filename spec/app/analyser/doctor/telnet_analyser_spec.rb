require "spec_helper"

RSpec.describe Doctor::TelnetAnalyser do

  subject do
    described_class.new.analyse
  end

  describe "#analyse" do

    context "When process with sucess" do
      
      before do
        expect(Net::Telnet).to receive(:new).with(
          "Host"     => "uaihebert.com",
          "Port"     => 80,
          "Timeout"  => 1,
          "Waittime" => 1 
        )

        expect(Net::Telnet).to receive(:new).with(
          "Host"     => "api.paypal.com",
          "Port"     => 443,
          "Timeout"  => 10,
          "Waittime" => 20 
        )
        Doctor::ConfigManager.url_to_telnet_list.concat [
          {name: 'uaiHebert', host: 'uaihebert.com'},
          {name: 'Paypal',    host: 'api.paypal.com', port: 443, timeout: 10, wait_time: 20}
        ]
      end

      after do
        Doctor::ConfigManager.url_to_telnet_list.clear
      end

      it "Does return a object with status attribte value 'ok'" do
        expect(subject.first.status).to eq("ok")
      end

      it "Does return a object with host attribte" do
        expect(subject.first.host).to eq("uaihebert.com")
      end

      it "Does return a object with port attribte" do
        expect(subject.first.port).to eq(80)
      end

      it "Does return a object with timeout attribte" do
        expect(subject.first.timeout).to eq(1)
      end

      it "Does return a object with wait_time attribte" do
        expect(subject.first.wait_time).to eq(1)
      end

    end

    context "When process with failed" do
      
      before do 
        expect(Net::Telnet).to receive(:new).and_raise("i_have_failed") 
        Doctor::ConfigManager.url_to_telnet_list.concat [
          {name: 'Paypal',host: 'api.paypal.com', port: 443, timeout: 10, wait_time: 20}]
      end

      after do
        Doctor::ConfigManager.url_to_telnet_list.clear
      end

      it "Does return a object with status attribute value 'error'" do
        expect(subject.first.status).to eq("error")
      end

      it "Does return a object with error_message attribute value 'caused_by'" do
        expect(subject.first.error_message).to eq("i_have_failed")
      end

      it "Does return a object with host attribte" do
        expect(subject.first.host).to eq("api.paypal.com")
      end

      it "Does return a object with port attribte" do
        expect(subject.first.port).to eq(443)
      end

      it "Does return a object with timeout attribte" do
        expect(subject.first.timeout).to eq(10)
      end

      it "Does return a object with wait_time attribte" do
        expect(subject.first.wait_time).to eq(20)
      end
    end
  end
end
