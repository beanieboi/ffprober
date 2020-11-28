# typed: true
# frozen_string_literal: true

require 'test_helper'

module Ffprober
  module Ffmpeg
    class ExecTest < Minitest::Test
      extend T::Sig

      class FakeFinder
        attr_writer :path
        attr_reader :path
      end

      sig {returns(TrueClass)}
      def test_output_without_ffmpeg
        finder = FakeFinder.new
        finder.path = nil
        exec = Ffprober::Ffmpeg::Exec.new(finder)
        assert '', exec.ffprobe_version_output
      end

      sig {returns(TrueClass)}
      def test_output_with_ffmpeg
        finder = FakeFinder.new
        finder.path = fake_ffprobe_version_path
        exec = Ffprober::Ffmpeg::Exec.new(finder)
        assert_equal "fake_version_output\n", exec.ffprobe_version_output
      end

      sig {returns(TrueClass)}
      def test_json_output
        finder = FakeFinder.new
        finder.path = fake_ffprobe_output_path
        exec = Ffprober::Ffmpeg::Exec.new(finder)
        assert_equal "fake_version_output\n", exec.json_output("")
      end
    end
  end
end
