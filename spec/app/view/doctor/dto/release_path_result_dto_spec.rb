require 'spec_helper'

RSpec.describe Doctor::Dto::ReleasePathResultDto do
  subject do
    described_class.new(params)
  end

  context 'Check visibility of attributes' do
    let(:params) do
      { status: 'ok', path: '20160608031232', last: '20160608031232' }
    end

    it 'Does status is public' do
      expect(subject).to respond_to(:status)
    end

    it 'Does path is private' do
      expect(subject).to_not respond_to(:path)
    end

    it 'Does last is private' do
      expect(subject).to_not respond_to(:last)
    end
  end
end
