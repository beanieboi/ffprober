# encoding: utf-8
require 'spec_helper'

describe Ffprober::FfprobeVersion do
  let(:before_one_zero) { Gem::Version.new("0.9.0") }
  let(:one_zero)        { Gem::Version.new("1.0.0") }
  let(:one_one)         { Gem::Version.new("1.1.0") }
  let(:after_one_zero)  { Gem::Version.new("1.9.0") }
  let(:latest)          { Gem::Version.new("1.2.1") }

  context 'validates the ffprobe version' do
    it '< 0.9' do
      Ffprober::FfprobeVersion.any_instance.stub(:version) { before_one_zero }
      Ffprober::FfprobeVersion.valid?.should be_true
    end

    it '1.0' do
      Ffprober::FfprobeVersion.any_instance.stub(:version) { one_zero }
      Ffprober::FfprobeVersion.valid?.should be_true
    end

    it '1.1' do
      Ffprober::FfprobeVersion.any_instance.stub(:version) { one_one }
      Ffprober::FfprobeVersion.valid?.should be_true
    end

    it '1.9' do
      Ffprober::FfprobeVersion.any_instance.stub(:version) { after_one_zero }
      Ffprober::FfprobeVersion.valid?.should be_false
    end

    it 'latest' do
      Ffprober::FfprobeVersion.any_instance.stub(:version) { latest }
      Ffprober::FfprobeVersion.valid?.should be_true
    end

  end
end
