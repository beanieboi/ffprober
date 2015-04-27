# encoding: utf-8
require "spec_helper"

def shared_specs
  describe "format" do
    it "should determine the correct filename" do
      expect(ffprobe.format.filename).to eq("spec/assets/sample video.m4v")
    end

    it "should find the correct size" do
      expect(ffprobe.format.size).to eq("4611")
    end

    it "should find the correct bit_rate" do
      expect(ffprobe.format.bit_rate).to eq("377950")
    end
  end

  describe "audio_streams" do
    it "should determine the correct number of audio streams" do
      expect(ffprobe.audio_streams.count).to eq(1)
    end

    it "should determine the correct sample rate of the first audio stream" do
      expect(ffprobe.audio_streams.first.sample_rate).to eq("44100")
    end
  end

  describe "subtitle_streams" do
    it "should determine the correct duration_ts of the first subtitle stream" do
      expect(ffprobe.subtitle_streams.first.duration_ts).to eq(98)
    end

    it "should determine the correct bitrate of the first subtitle stream" do
      expect(ffprobe.subtitle_streams.first.bit_rate).to eq("5690")
    end

    it "should determine the correct language of the first subtitle stream" do
      expect(ffprobe.subtitle_streams.first.tags[:language]).to eq("eng")
    end

    it "should determine the correct number of subtitle streams" do
      expect(ffprobe.subtitle_streams.count).to eq(1)
    end
  end

  describe "video_streams" do
    it "should determine the correct width of the first video streams" do
      expect(ffprobe.video_streams.first.width).to eq(480)
    end

    it "should determine the correct width of the first video streams" do
      expect(ffprobe.video_streams.first.height).to eq(272)
    end

    it "should determine the correct number of video streams" do
      expect(ffprobe.video_streams.count).to eq(1)
    end
  end

  describe "chapters" do
    it "should contain the chapters" do
      expect(ffprobe.chapters.count).to eq(3)
    end

    describe "chapter" do
      subject(:chapter) { ffprobe.chapters.first }

      it "should contain id" do
        expect(chapter.id).to eq(0)
      end
      it "should contain time_base" do
        expect(chapter.time_base).to eq("1/1000")
      end
      it "should contain start" do
        expect(chapter.start).to eq(0)
      end
      it "should contain start_time" do
        expect(chapter.start_time).to eq("0.000000")
      end
      it "should contain end" do
        expect(chapter.end).to eq(10)
      end
      it "should contain end_time" do
        expect(chapter.end_time).to eq("0.010000")
      end
      it "should contain tags" do
        expect(chapter.tags).to eq(title: "Chapter 1")
      end
    end
  end
end

RSpec.describe Ffprober::Parser do
  context "from_file", if: Ffprober::FfprobeVersion.valid? do
    let(:ffprobe) { Ffprober::Parser.from_file("spec/assets/sample video.m4v") }

    shared_specs
  end

  context "from_json" do
    let(:ffprobe) { Ffprober::Parser.from_json(File.read("spec/assets/sample video.json")) }

    shared_specs
  end

  context "from invalid file", if: Ffprober::FfprobeVersion.valid? do
    let(:ffprobe) { Ffprober::Parser.from_file("spec/assets/empty_file") }

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
end
