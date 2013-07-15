# encoding: utf-8
require 'spec_helper'

describe Ffprober::FfprobeVersion do
  VERSION_CHECKS = [
    { version: "0.9.0", pass: true },
    { version: "1.0.0", pass: true },
    { version: "1.1.0", pass: true },
    { version: "2.9.0", pass: false },
    { version: "1.2.1", pass: true },
    { version: "2.0", pass: true}
  ]

  context 'validates the ffprobe version' do
    VERSION_CHECKS.each do |check|
      it "detects version #{check[:version]}" do
        Ffprober::FfprobeVersion.any_instance.stub(:version) { Gem::Version.new(check[:version]) }
        Ffprober::FfprobeVersion.valid?.should be(check[:pass])
      end
    end
  end

  describe 'detects the version of ffprobe' do
    Dir.new("spec/assets/version_outputs").each do |entry|
      next if [".", "..", ".DS_Store"].include?(entry)
      os, expected_version = entry.split("-")

      it "on #{os} from #{expected_version}" do
        version_output = File.read("spec/assets/version_outputs/" + entry)
        Ffprober::FfprobeVersion.any_instance.stub(:version_output) { version_output }
        version_check = Ffprober::FfprobeVersion.new

        if expected_version == "nightly"
          version_check.nightly?.should eq(true)
          version_check.valid?.should eq(true)
        else
          version_check.version.should eq(Gem::Version.new(expected_version.gsub("_", ".")))
        end
      end
    end

    it "should not be valid if no ffprobe could be found in PATH" do
      Ffprober.stub(:path).and_return(nil)
      Ffprober::FfprobeVersion.new.version.to_s.should eq("0.0.0")
      Ffprober::FfprobeVersion.valid?.should eq(false)
    end

  end
end
