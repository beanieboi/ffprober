# encoding: utf-8
require 'spec_helper'

describe Ffprober::FfprobeVersion do
  VERSION_CHECKS = [
    { version: '0.9.0', pass: true },
    { version: '1.0.0', pass: true },
    { version: '1.1.0', pass: true },
    { version: '2.9.0', pass: false },
    { version: '1.2.1', pass: true },
    { version: '2.0', pass: true }
  ]

  subject(:ffprobe_version) { Ffprober::FfprobeVersion.new }

  context 'validates the ffprobe version' do
    VERSION_CHECKS.each do |check|
      it "detects version #{check[:version]}" do
        allow(ffprobe_version).to receive(:version).and_return(Gem::Version.new(check[:version]))
        expect(ffprobe_version.valid?).to be(check[:pass])
      end
    end
  end

  describe 'detects the version of ffprobe' do
    Dir.new('spec/assets/version_outputs').each do |entry|
      next if ['.', '..', '.DS_Store'].include?(entry)
      os, expected_version = entry.split('-')

      it "on #{os} from #{expected_version}" do
        version_output = File.read('spec/assets/version_outputs/' + entry)

        allow(ffprobe_version).to receive(:ffprobe_version_output).and_return(version_output)

        if expected_version == 'nightly'
          expect(ffprobe_version.nightly?).to eq(true)
          expect(ffprobe_version.valid?).to eq(true)
        else
          expect(ffprobe_version.version).to eq(Gem::Version.new(expected_version.gsub('_', '.')))
        end
      end
    end

    it 'should not be valid if no ffprobe could be found in PATH' do
      allow(Ffprober).to receive(:path).and_return(nil)
      expect(ffprobe_version.version.to_s).to eq('0.0.0')
      expect(Ffprober::FfprobeVersion.valid?).to eq(false)
    end

  end
end
