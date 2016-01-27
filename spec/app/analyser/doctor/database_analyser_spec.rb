require "spec_helper"

class Dog 
end

RSpec.describe Doctor::DatabaseAnalyser do

  subject do
    described_class.new.analyse
  end

  describe "#analyse" do

    before do
      expect(Dog).to receive(:model_name).and_return(Dog.name.to_s)
      Doctor::ConfigManager.active_record_list.concat [Dog]
    end

    after do
      Doctor::ConfigManager.active_record_list.clear
    end

    context "When process with success" do

      before do
        expect(Dog).to receive(:first).and_return(Dog.new)
      end

      it "Does return a object with status attribute value 'ok'" do
        expect(subject.first.status).to eq("ok")
      end

      it "Does return a object with active_record attribute value 'dog'" do
        expect(subject.first.active_record).to eq(Dog.name.to_s)
      end

      it "Does return a object with error_message attribute value nil" do
        expect(subject.first.error_message).to be_nil
      end
    end

    context "When process with failed" do

      before do
        expect(Dog).to receive(:first).and_raise("i_have_failed")
      end

      it "Does return a object with status attribute value 'error'" do
        expect(subject.first.status).to eq("error")
      end

      it "Does return a object with error_message attribute value 'i_have_failed'" do
        expect(subject.first.status).to eq("error")
      end
    end
  end
end
