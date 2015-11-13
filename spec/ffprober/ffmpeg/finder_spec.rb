require "spec_helper"

RSpec.describe Ffprober::Ffmpeg::Finder do
  describe "if no ffprobe is found" do
    it "should raise a exception if there is no ffmpeg" do
      allow(described_class).to receive(:path).and_return("nonexistant")

      expect do
        Ffprober::Parser.from_file("spec/assets/301-extracting_a_ruby_gem.m4v")
      end.to raise_error(Errno::ENOENT)
    end

    it "should raise a exception if there is no valid ffmpeg" do
      allow(Ffprober::FfprobeVersion).to receive(:invalid?).and_return(true)

      expect do
        Ffprober::Parser.from_file("spec/assets/301-extracting_a_ruby_gem.m4v")
      end.to raise_error(Ffprober::UnsupportedVersion)
    end
  end
end
