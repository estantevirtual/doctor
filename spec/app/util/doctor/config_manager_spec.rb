require "spec_helper"

RSpec.describe Doctor::ConfigManager do

  subject do
    described_class
  end

  describe ".active_record_list" do

    it "Does return new value on attribute 'active_record_list'" do
      subject.active_record_list << "hello"
      subject.active_record_list << "say"
      expect(subject.active_record_list).to match_array(["hello", "say"]) 
    end
  end

  describe ".url_to_telnet_list" do

    it "Does return new value on attribute 'url_to_telnet_list'" do
      subject.url_to_telnet_list << "telnet"
      subject.url_to_telnet_list << "list"
      expect(subject.url_to_telnet_list).to match_array(["list", "telnet"]) 
    end
  end
end
