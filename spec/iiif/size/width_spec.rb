require 'spec_helper'

RSpec.describe IIIF::Image::Size::Width do
  let(:instance) { described_class.new(100) }
  describe '#height_for_aspect_ratio' do
    subject { instance.height_for_aspect_ratio(0.5) }
    it { is_expected.to eq 200}
  end
end
