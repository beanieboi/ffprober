require "spec_helper"

RSpec.describe Ffprober::Ffmpeg::VersionValidator do
  VERSION_CHECKS = [
    { version: "0.9.0", pass: true },
    { version: "1.0.0", pass: true },
    { version: "1.1.0", pass: true },
    { version: "2.9.0", pass: false },
    { version: "1.2.1", pass: true },
    { version: "2.0",   pass: true },
    { version: "2.0.1", pass: true },
    { version: "2.0.2", pass: true },
    { version: "2.1.1", pass: true },
    { version: "2.1.2", pass: true },
    { version: "2.1.4", pass: true },
    { version: "2.2",   pass: true },
    { version: "2.2.2", pass: true },
    { version: "2.5.4", pass: true }
  ]

  context "validates the ffprobe version" do
    VERSION_CHECKS.each do |check|
      it "detects version #{check[:version]}" do
        ffmpeg_version = FakeVersion.new(Gem::Version.new(check[:version]), false)
        validator = described_class.new(ffmpeg_version)
        expect(validator.valid?).to be(check[:pass])
      end
    end

    it "allows nightly versions" do
      ffmpeg_version = FakeVersion.new(Gem::Version.new("99.0"), true)
      validator = described_class.new(ffmpeg_version)
      expect(validator.valid?).to be(true)
    end
  end

  class FakeVersion
    def initialize(version, nightly)
      @version = version
      @nightly = nightly
    end

    def version
      @version
    end

    def nightly?
      @nightly
    end
  end
end
