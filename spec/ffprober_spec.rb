# encoding: utf-8
require 'spec_helper'

describe Ffprober do

  describe 'if no ffprobe is found' do
    it 'should raise a exception if there is no ffmpeg' do
      allow(Ffprober).to receive(:path).and_return('nonexistant')

      expect do
        Ffprober::Parser.from_file('spec/assets/301-extracting_a_ruby_gem.m4v')
      end.to raise_error
    end

    it 'should raise a exception if there is no valid ffmpeg' do
      allow(Ffprober::FfprobeVersion).to receive(:valid?).and_return(false)

      expect do
        Ffprober::Parser.from_file('spec/assets/301-extracting_a_ruby_gem.m4v')
      end.to raise_error(ArgumentError)
    end
  end
end
