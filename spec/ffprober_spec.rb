# encoding: utf-8
require 'spec_helper'

describe Ffprober do
  before :each do
    @ffprobe = Ffprober::Parser.from_json(File.read('spec/assets/301-extracting_a_ruby_gem.json'))
  end

  describe "format" do
    it "should determine the correct filename" do
      @ffprobe.format.filename.should eq("301-extracting-a-ruby-gem.mp4")
    end

    it "should find the correct size" do
      @ffprobe.format.size.should eq("44772490")
    end

    it "should find the correct bit_rate" do
      @ffprobe.format.bit_rate.should eq("361309")
    end
  end

  describe "audio_streams" do
    it "should determine the correct number of audio streams" do
      @ffprobe.audio_streams.count.should eq(1)
    end

    it "should determine the correct sample rate of the first audio stream" do
      @ffprobe.audio_streams.first.sample_rate.should eq("48000")
    end

  end

  describe "video_streams" do
    it "should determine the correct width of the first video streams" do
      @ffprobe.video_streams.first.width.should eq(960)
    end

    it "should determine the correct width of the first video streams" do
      @ffprobe.video_streams.first.height.should eq(600)
    end

    it "should determine the correct number of video streams" do
      @ffprobe.video_streams.count.should eq(1)
    end
  end

end
