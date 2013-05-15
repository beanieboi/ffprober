# encoding: utf-8
require 'spec_helper'

describe Ffprober do
  describe "from_file", if: Ffprober::FfprobeVersion.valid? do
    before :each do
      @ffprobe = Ffprober::Parser.from_file('spec/assets/301-extracting_a_ruby_gem.m4v')
    end

    describe "format" do
      it "should determine the correct filename" do
        @ffprobe.format.filename.should eq("spec/assets/301-extracting_a_ruby_gem.m4v")
      end

      it "should find the correct size" do
        @ffprobe.format.size.should eq("130694")
      end

      it "should find the correct bit_rate" do
        @ffprobe.format.bit_rate.should eq("502669")
      end
    end
  end

  describe "from invalid file", if: Ffprober::FfprobeVersion.valid? do
    before :each do
      @ffprobe = Ffprober::Parser.from_file('spec/assets/empty_file')
    end

    describe "format" do
      it "should determine the correct filename" do
        expect do
          @ffprobe.format.filename.should eq("spec/assets/empty_file")
        end.to raise_error
      end

      it "should find the correct size" do
        expect do
          @ffprobe.format.size.should eq("130694")
        end.to raise_error
      end

      it "should find the correct bit_rate" do
        expect do
          @ffprobe.format.bit_rate.should eq("502669")
        end.to raise_error
      end
    end
  end

  describe "if no ffprobe is found" do
    it "should raise a exception" do
      Ffprober.stub(:path).and_return("nonexistant")
      lambda { @ffprobe = Ffprober::Parser.from_file('spec/assets/301-extracting_a_ruby_gem.m4v') }.should raise_error
    end
  end

  describe "from_json" do
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
end
