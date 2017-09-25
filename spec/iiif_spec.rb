require 'spec_helper'

describe IIIF::Image do
  it 'has a version number' do
    expect(IIIF::Image::VERSION).not_to be nil
  end
end
