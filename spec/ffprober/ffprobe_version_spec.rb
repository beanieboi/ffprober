# encoding: utf-8
require 'spec_helper'

describe Ffprober::FfprobeVersion do
  let(:before_one_zero) { Gem::Version.new("0.9.0") }
  let(:one_zero)        { Gem::Version.new("1.0.0") }
  let(:one_one)         { Gem::Version.new("1.1.0") }
  let(:after_one_zero)  { Gem::Version.new("1.9.0") }
  let(:latest)          { Gem::Version.new("1.2.1") }

  context 'validates the ffprobe version' do
    it 'detects versions < 0.9' do
      Ffprober::FfprobeVersion.stub(:parsed_version) { before_one_zero }
      Ffprober::FfprobeVersion.valid?.should be_true
    end

    it 'detects versions 1.0' do
      Ffprober::FfprobeVersion.stub(:parsed_version) { one_zero }
      Ffprober::FfprobeVersion.valid?.should be_true
    end

    it 'detects versions 1.1' do
      Ffprober::FfprobeVersion.stub(:parsed_version) { one_one }
      Ffprober::FfprobeVersion.valid?.should be_true
    end

    it 'detects versions 1.9' do
      Ffprober::FfprobeVersion.stub(:parsed_version) { after_one_zero }
      Ffprober::FfprobeVersion.valid?.should be_false
    end

    it 'detects latest' do
      Ffprober::FfprobeVersion.stub(:parsed_version) { latest }
      Ffprober::FfprobeVersion.valid?.should be_true
    end

  end
end
