# encoding: utf-8
require 'spec_helper'

describe Ffprober::Parser do

  describe "from_file", if: Ffprober::FfprobeVersion.valid? do
    let(:ffprobe) { Ffprober::Parser.from_file('spec/assets/301-extracting_a_ruby_gem.m4v') }

    describe "format" do
      it "should determine the correct filename" do
        expect(ffprobe.format.filename).to eq("spec/assets/301-extracting_a_ruby_gem.m4v")
      end

      it "should find the correct size" do
        expect(ffprobe.format.size).to eq("130694")
      end

      it "should find the correct bit_rate" do
        expect(ffprobe.format.bit_rate).to eq("502669")
      end
    end
  end

  describe "from invalid file", if: Ffprober::FfprobeVersion.valid? do
    let(:ffprobe) { Ffprober::Parser.from_file('spec/assets/empty_file') }

    describe "format" do
      it "should determine the correct filename" do
        expect { ffprobe.format.filename }.to raise_error
      end

      it "should find the correct size" do
        expect { ffprobe.format.size }.to raise_error
      end

      it "should find the correct bit_rate" do
        expect { ffprobe.format.bit_rate }.to raise_error
      end
    end
  end

  describe "from_json" do
    let(:ffprobe) { Ffprober::Parser.from_json(File.read('spec/assets/301-extracting_a_ruby_gem.json')) }

    describe "format" do
      it "should determine the correct filename" do
        expect(ffprobe.format.filename).to eq("301-extracting-a-ruby-gem.mp4")
      end

      it "should find the correct size" do
        expect(ffprobe.format.size).to eq("44772490")
      end

      it "should find the correct bit_rate" do
        expect(ffprobe.format.bit_rate).to eq("361309")
      end
    end

    describe "audio_streams" do
      it "should determine the correct number of audio streams" do
        expect(ffprobe.audio_streams.count).to eq(1)
      end

      it "should determine the correct sample rate of the first audio stream" do
        expect(ffprobe.audio_streams.first.sample_rate).to eq("48000")
      end

    end

    describe "video_streams" do
      it "should determine the correct width of the first video streams" do
        expect(ffprobe.video_streams.first.width).to eq(960)
      end

      it "should determine the correct width of the first video streams" do
        expect(ffprobe.video_streams.first.height).to eq(600)
      end

      it "should determine the correct number of video streams" do
        expect(ffprobe.video_streams.count).to eq(1)
      end
    end
  end

end
