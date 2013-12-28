# encoding: utf-8
require 'spec_helper'

describe Ffprober::Parser do

  context "from_file with whitespace", if: Ffprober::FfprobeVersion.valid? do
    let(:ffprobe) { Ffprober::Parser.from_file('spec/assets/301 extracting a ruby gem.m4v') }

    describe "format" do
      it "should determine the correct filename" do
        expect(ffprobe.format.filename).to eq("spec/assets/301 extracting a ruby gem.m4v")
      end
    end
  end

  context "from_file", if: Ffprober::FfprobeVersion.valid? do
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

  context "from invalid file", if: Ffprober::FfprobeVersion.valid? do
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

  context "from_json" do
    let(:ffprobe) { Ffprober::Parser.from_json(File.read('spec/assets/m4a-with-chapters.json')) }

    describe "format" do
      it "should determine the correct filename" do
        expect(ffprobe.format.filename).to eq("fs123-schland-unter.m4a")
      end

      it "should find the correct size" do
        expect(ffprobe.format.size).to eq("81285909")
      end

      it "should find the correct bit_rate" do
        expect(ffprobe.format.bit_rate).to eq("51026")
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

    describe "video_streams" do
      it "should determine the correct width of the first video streams" do
        expect(ffprobe.video_streams.first.width).to eq(1400)
      end

      it "should determine the correct width of the first video streams" do
        expect(ffprobe.video_streams.first.height).to eq(1400)
      end

      it "should determine the correct number of video streams" do
        expect(ffprobe.video_streams.count).to eq(2)
      end
    end

    describe "chapters" do
      it "should contain the chapters" do
        expect(ffprobe.chapters.count).to eq(13)
      end

      describe "chapter" do
        subject(:chapter) { ffprobe.chapters.first }

        it "should contain id" do expect(chapter.id).to eq(0) end
        it "should contain time_base" do expect(chapter.time_base).to eq("1/1000") end
        it "should contain start" do expect(chapter.start).to eq(0) end
        it "should contain start_time" do expect(chapter.start_time).to eq("0.000000") end
        it "should contain end" do expect(chapter.end).to eq(204000) end
        it "should contain end_time" do expect(chapter.end_time).to eq("204.000000") end
        it "should contain tags" do expect(chapter.tags).to eq({:title=>"Intro"}) end
      end
    end
  end

end
