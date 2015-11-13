require "spec_helper"

RSpec.describe Ffprober::Ffmpeg::Version do
  let(:ffprobe_finder)      { Ffprober::Ffmpeg::Finder }
  subject(:ffprobe_version) { described_class.new }

  describe "detects the version of ffprobe" do
    Dir.new("spec/assets/version_outputs").each do |entry|
      next if [".", "..", ".DS_Store"].include?(entry)
      os, expected_version = entry.split("-")

      it "on #{os} from #{expected_version}" do
        version_output = File.read("spec/assets/version_outputs/" + entry)

        allow(ffprobe_version).to receive(:ffprobe_version_output).and_return(version_output)

        if expected_version == "nightly"
          expect(ffprobe_version.nightly?).to eq(true)
        else
          expect(ffprobe_version.version).to eq(Gem::Version.new(expected_version.tr("_", ".")))
        end
      end
    end

    it "should not be valid if no ffprobe could be found in PATH" do
      allow(ffprobe_finder).to receive(:path).and_return(nil)
      expect(ffprobe_version.version.to_s).to eq("0.0.0")
      expect(Ffprober::FfprobeVersion.valid?).to eq(false)
    end
  end
end
