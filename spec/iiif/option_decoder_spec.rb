require 'spec_helper'

RSpec.describe IIIF::Image::OptionDecoder do
  describe '#decode' do
    subject { described_class.decode(options) }
    let(:size) { 'max' }
    let(:region) { 'full' }
    let(:options) { { region: region, size: size } }

    describe 'of a full region' do
      it { is_expected.to be_a IIIF::Image::Transformation }
      it 'has correct parameters' do
        expect(subject.size).to be_a IIIF::Image::Size::Max
        expect(subject.region).to be_a IIIF::Image::Region::Full
      end
    end

    describe 'of a percent region' do
      let(:region) { 'pct:10,10,10,10' }
      it 'has correct parameters' do
        expect(subject.region).to be_a IIIF::Image::Region::Percent
        expect(subject.region.to_s).to eq 'pct:10.0,10.0,10.0,10.0'
      end
    end
  end
end
