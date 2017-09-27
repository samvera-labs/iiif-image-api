require 'spec_helper'

RSpec.describe IIIF::Image::Size::Height do
  let(:instance) { described_class.new(100) }
  describe '#width_for_aspect_ratio' do
    subject { instance.width_for_aspect_ratio(0.5) }
    it { is_expected.to eq 50 }
  end
end
