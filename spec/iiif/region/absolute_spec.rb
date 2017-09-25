require 'spec_helper'

RSpec.describe IIIF::Image::Region::Absolute do
  let(:instance) { described_class.new(1, 2, 3, 4) }
  describe "#to_s" do
    subject { instance.to_s }
    it { is_expected.to eq '1,2,3,4' }
  end
end
