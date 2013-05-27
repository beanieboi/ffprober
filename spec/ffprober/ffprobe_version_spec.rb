# encoding: utf-8
require 'spec_helper'

describe Ffprober::FfprobeVersion do
  VERSION_CHECKS = [
    { version: "0.9.0", pass: true },
    { version: "1.0.0", pass: true },
    { version: "1.1.0", pass: true },
    { version: "1.9.0", pass: false },
    { version: "1.2.1", pass: true }
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
        Ffprober::FfprobeVersion.any_instance.stub(:version_output) { File.read("spec/assets/version_outputs/" + entry) }

        version_check = Ffprober::FfprobeVersion.new
        version_check.version.should eq(Gem::Version.new(expected_version.gsub("_", ".")))
      end
    end
  end
end
