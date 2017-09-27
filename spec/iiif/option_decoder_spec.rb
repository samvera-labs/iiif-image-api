require 'spec_helper'

RSpec.describe IIIF::Image::OptionDecoder do
  describe '#decode' do
    subject { described_class.decode(options) }
    let(:size) { 'max' }
    let(:region) { 'full' }
    let(:rotation) { '0' }
    let(:format) { 'jpg' }
    let(:options) do
      { region: region, size: size, rotation: rotation, format: format }
    end

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

    describe 'of an absolute region' do
      let(:region) { '10,10,10,10' }
      it 'has correct parameters' do
        expect(subject.region).to be_a IIIF::Image::Region::Absolute
        expect(subject.region.to_s).to eq '10,10,10,10'
      end
    end

    describe 'of an square region' do
      let(:region) { 'square' }
      it 'has correct parameters' do
        expect(subject.region).to be_a IIIF::Image::Region::Square
        expect(subject.region.to_s).to eq 'square'
      end
    end

    describe 'of an invalid region' do
      let(:region) { 'triangle' }
      it 'raises an error' do
        expect { subject }.to raise_error IIIF::Image::InvalidAttributeError
      end
    end

    describe 'of a full size' do
      let(:size) { 'full' }
      it 'has correct parameters' do
        expect(subject.size).to be_a IIIF::Image::Size::Full
        expect(subject.size.to_s).to eq 'full'
      end
    end

    describe 'of a height size' do
      let(:size) { ',512' }
      it 'has correct parameters' do
        expect(subject.size).to be_a IIIF::Image::Size::Height
        expect(subject.size.to_s).to eq ',512'
      end
    end

    describe 'of a width size' do
      let(:size) { '512,' }
      it 'has correct parameters' do
        expect(subject.size).to be_a IIIF::Image::Size::Width
        expect(subject.size.to_s).to eq '512,'
      end
    end

    describe 'of a percent size' do
      let(:size) { 'pct:10.3' }
      it 'has correct parameters' do
        expect(subject.size).to be_a IIIF::Image::Size::Percent
        expect(subject.size.to_s).to eq 'pct:10.3'
      end
    end

    describe 'of a best fit' do
      let(:size) { '!400,400' }
      it 'has correct parameters' do
        expect(subject.size).to be_a IIIF::Image::Size::BestFit
        expect(subject.size.to_s).to eq '!400,400'
      end
    end

    describe 'of an invalid size' do
      let(:size) { 'huge' }
      it 'raises an error' do
        expect { subject }.to raise_error IIIF::Image::InvalidAttributeError
      end
    end

    describe 'of an invalid rotation' do
      let(:rotation) { 'left' }
      it 'raises an error' do
        expect { subject }.to raise_error IIIF::Image::InvalidAttributeError
      end
    end

    describe 'of an arbitrary rotation' do
      let(:rotation) { '9.5' }
      it 'has correct parameters' do
        expect(subject.rotation).to eq 9.5
      end
    end

    describe 'of an invalid format' do
      let(:format) { 'jp2' }
      it 'raises an error' do
        expect { subject }.to raise_error IIIF::Image::InvalidAttributeError
      end
    end
  end
end
