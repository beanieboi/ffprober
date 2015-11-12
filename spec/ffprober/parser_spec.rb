# encoding: utf-8
require "spec_helper"

RSpec.describe Ffprober::Parser do
  it "parses the content from file", if: Ffprober::FfprobeVersion.valid? do
    ffprobe = Ffprober::Parser.from_file("spec/assets/s'ample video.m4v")

    expect(ffprobe.format.filename).to eq("spec/assets/s'ample video.m4v")
    expect(ffprobe.format.size).to eq("4611")
    expect(ffprobe.format.bit_rate).to eq("377950")

    expect(ffprobe.audio_streams.count).to eq(1)
    expect(ffprobe.audio_streams.first.sample_rate).to eq("44100")

    expect(ffprobe.subtitle_streams.count).to eq(1)
    expect(ffprobe.subtitle_streams.first.duration_ts).to eq(98)
    expect(ffprobe.subtitle_streams.first.bit_rate).to eq("5690")
    expect(ffprobe.subtitle_streams.first.tags[:language]).to eq("eng")

    expect(ffprobe.video_streams.first.width).to eq(480)
    expect(ffprobe.video_streams.first.height).to eq(272)
    expect(ffprobe.video_streams.count).to eq(1)

    expect(ffprobe.chapters.count).to eq(3)
    expect(ffprobe.chapters.first.id).to eq(0)
    expect(ffprobe.chapters.first.time_base).to eq("1/1000")
    expect(ffprobe.chapters.first.start).to eq(0)
    expect(ffprobe.chapters.first.start_time).to eq("0.000000")
    expect(ffprobe.chapters.first.end).to eq(10)
    expect(ffprobe.chapters.first.end_time).to eq("0.010000")
    expect(ffprobe.chapters.first.tags).to eq(title: "Chapter 1")
  end

  it "parses the content from JSON" do
    ffprobe = Ffprober::Parser.from_json(File.read("spec/assets/sample video.json"))

    expect(ffprobe.format.filename).to eq("spec/assets/sample video.m4v")
    expect(ffprobe.format.size).to eq("4611")
    expect(ffprobe.format.bit_rate).to eq("377950")

    expect(ffprobe.audio_streams.count).to eq(1)
    expect(ffprobe.audio_streams.first.sample_rate).to eq("44100")

    expect(ffprobe.subtitle_streams.count).to eq(1)
    expect(ffprobe.subtitle_streams.first.duration_ts).to eq(98)
    expect(ffprobe.subtitle_streams.first.bit_rate).to eq("5690")
    expect(ffprobe.subtitle_streams.first.tags[:language]).to eq("eng")

    expect(ffprobe.video_streams.first.width).to eq(480)
    expect(ffprobe.video_streams.first.height).to eq(272)
    expect(ffprobe.video_streams.count).to eq(1)

    expect(ffprobe.chapters.count).to eq(3)
    expect(ffprobe.chapters.first.id).to eq(0)
    expect(ffprobe.chapters.first.time_base).to eq("1/1000")
    expect(ffprobe.chapters.first.start).to eq(0)
    expect(ffprobe.chapters.first.start_time).to eq("0.000000")
    expect(ffprobe.chapters.first.end).to eq(10)
    expect(ffprobe.chapters.first.end_time).to eq("0.010000")
    expect(ffprobe.chapters.first.tags).to eq(title: "Chapter 1")
  end

  it "parses data streams" do
    ffprobe = Ffprober::Parser.from_json(File.read("spec/assets/data_streams.json"))

    expect(ffprobe.data_streams.first.tags[:reel_name]).to eq("NO NAME")
  end

  it "it raises an error if the file is invalid", if: Ffprober::FfprobeVersion.valid? do
    ffprobe = Ffprober::Parser.from_file("spec/assets/empty_file")
    expect { ffprobe.format.filename }.to raise_error
    expect { ffprobe.format.size }.to raise_error
    expect { ffprobe.format.bit_rate }.to raise_error
  end
end
