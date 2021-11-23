# typed: true
# frozen_string_literal: true

require 'test_helper'

module Ffprober
  module Ffmpeg
    class FinderTest < Minitest::Test
      def test_finder
        Ffprober::Ffmpeg::Finder.new
      end

      def test_executable_name
        assert_equal 'ffprobe', test_finder.executable_name
      end
    end
  end
end
