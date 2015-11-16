require "spec_helper"

RSpec.describe Ffprober::Ffmpeg::Finder do
  it "should raise a exception if there is no ffmpeg" do
    expect do
      Ffprober::Parser.from_file("spec/assets/301-extracting_a_ruby_gem.m4v")
    end.to raise_error(Ffprober::UnsupportedVersion)
  end

  it "should raise a exception if there is no valid ffmpeg" do
    expect do
      Ffprober::Parser.from_file("spec/assets/301-extracting_a_ruby_gem.m4v")
    end.to raise_error(Ffprober::UnsupportedVersion)
  end
end
