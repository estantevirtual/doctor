require "spec_helper"
require 'sys/filesystem'

RSpec.describe Doctor::HdAnalyser do

  subject do
    described_class.new.analyse
  end

  describe "#analyse" do
    context "When process with sucess" do
      before do
        fake_hd = OpenStruct.new(block_size: 4096, blocks_available: 21997122, blocks: 28694674)
        expect(Sys::Filesystem).to receive(:stat).with('/uaiHd').and_return(fake_hd)
        expect(Sys::Filesystem).to receive(:stat).with('/evHd').and_return(fake_hd)

        Doctor::ConfigManager.directory_list.concat [
          {name: 'uaiHd', path: '/uaiHd', alarm_if_less_than: 80},
          {name: 'evHd', path: '/evHd', alarm_if_less_than: 80}
        ]
      end

      after do
        Doctor::ConfigManager.directory_list.clear
      end

      it "Does return a object with status attribte value 'ok'" do
        expect(subject.first.status).to eq("ok")
      end

      it "Does return a object with name attribte" do
        expect(subject.first.name).to eq("uaiHd")
      end

      it "Does return a object with path attribte" do
        expect(subject.first.path).to eq('/uaiHd')
      end

      it "Does return a object with alarm_if_less_than attribte" do
        expect(subject.first.alarm_if_less_than).to eq(80)
      end

    end

    context "When process with failed" do

      before do
        expect(Sys::Filesystem).to receive(:stat).and_raise("i_have_failed")
        Doctor::ConfigManager.directory_list.concat [
          {name: 'uaiHd', path: '/uaiHd', alarm_if_less_than: 80}
        ]
       end

      after do
        Doctor::ConfigManager.directory_list.clear
      end

      it "Does return a object with name attribte" do
        expect(subject.first.name).to eq("uaiHd")
      end

      it "Does return a object with path attribte" do
        expect(subject.first.path).to eq('/uaiHd')
      end

      it "Does return a object with alarm_if_less_than attribte" do
        expect(subject.first.alarm_if_less_than).to eq(80)
      end
    end
  end
end
