# encoding: utf-8
require "spec_helper"

RSpec.describe Ffprober::Parser do
  context "from_file", if: Ffprober::FfprobeVersion.valid? do
    let(:ffprobe) { Ffprober::Parser.from_file("spec/assets/sample video.m4v") }

    shared_format_specs
    shared_audio_specs
    shared_subtitle_specs
    shared_video_specs
    shared_chapter_specs
  end

  context "from_json" do
    let(:ffprobe) { Ffprober::Parser.from_json(File.read("spec/assets/sample video.json")) }

    shared_format_specs
    shared_audio_specs
    shared_subtitle_specs
    shared_video_specs
    shared_chapter_specs
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
