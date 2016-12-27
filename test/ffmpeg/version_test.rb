# frozen_string_literal: true
require 'test_helper'

class Ffprober::Ffmpeg::VersionTest < Minitest::Test
  class FakeExec
    attr_writer :output
    def ffprobe_version_output
      @output
    end
  end

  def test_version_output
    exec = FakeExec.new

    Dir.new('test/assets/version_outputs').each do |entry|
      next if ['.', '..', '.DS_Store'].include?(entry)
      os, expected_version = entry.split('-')

      version_output = File.read('test/assets/version_outputs/' + entry)
      exec.output = version_output

      ffprobe_version = Ffprober::Ffmpeg::Version.new(exec)

      if expected_version == 'nightly'
        assert ffprobe_version.nightly?
      else
        assert_equal Gem::Version.new(expected_version.tr('_', '.')), ffprobe_version.version
      end
    end
  end
end
