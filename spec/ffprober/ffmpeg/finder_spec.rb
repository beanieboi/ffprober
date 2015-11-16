require "spec_helper"

RSpec.describe Ffprober::Ffmpeg::Finder do
  it "should raise a exception if there is no ffmpeg" do
    allow(Ffprober::Ffmpeg::Finder).to receive(:executable_path) { nil }

    expect do
      Ffprober::Parser.from_file("spec/assets/301-extracting_a_ruby_gem.m4v")
    end.to raise_error(Ffprober::NoFfprobeFound)
  end

  it "should raise a exception if there is no valid ffmpeg" do
    allow_any_instance_of(Ffprober::Ffmpeg::Version).to receive(:nightly?) { false }
    allow_any_instance_of(Ffprober::Ffmpeg::Version).to receive(:version) { Gem::Version.new("0.0.0") }
    allow_any_instance_of(Ffprober::Ffmpeg::Version).to receive(:to_s) { "0.0.0" }

    expect do
      Ffprober::Parser.from_file("spec/assets/301-extracting_a_ruby_gem.m4v")
    end.to raise_error(Ffprober::UnsupportedVersion)
  end
end
