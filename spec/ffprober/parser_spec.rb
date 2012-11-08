# encoding: utf-8
require 'spec_helper'

describe Ffprober::Parser do
  let(:before_one_zero) { {major: 0, minor: 9, patch: 0} }
  let(:one_zero)        { {major: 1, minor: 0, patch: 0} }
  let(:after_one_zero)  { {major: 1, minor: 9, patch: 0} }

  context 'validates the ffprobe version' do
    it 'detects versions < 0.9' do
      Ffprober::Parser.stub(:ffprobe_version) { before_one_zero }
      Ffprober::Parser.ffprobe_version_valid?.should be_true
    end

    it 'detects versions 1.0' do
      Ffprober::Parser.stub(:ffprobe_version) { one_zero }
      Ffprober::Parser.ffprobe_version_valid?.should be_true
    end

    it 'detects versions 1.9' do
      Ffprober::Parser.stub(:ffprobe_version) { after_one_zero }
      Ffprober::Parser.ffprobe_version_valid?.should be_false
    end
  end
end
