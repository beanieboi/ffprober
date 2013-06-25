# encoding: utf-8
require 'spec_helper'

describe Ffprober do

  describe "if no ffprobe is found" do
    it "should raise a exception" do
      Ffprober.stub(:path).and_return("nonexistant")
      lambda { @ffprobe = Ffprober::Parser.from_file('spec/assets/301-extracting_a_ruby_gem.m4v') }.should raise_error
    end
  end

    it "should raise a exception if there is no valid ffmpeg" do
      Ffprober::FfprobeVersion.stub(:valid?).and_return(false)

      expect {
        @ffprobe = Ffprober::Parser.from_file('spec/assets/301-extracting_a_ruby_gem.m4v')
      }.to raise_error(ArgumentError)
    end
end
