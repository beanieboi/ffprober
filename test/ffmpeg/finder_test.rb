# typed: strict
# frozen_string_literal: true

require 'test_helper'

module Ffprober
  module Ffmpeg
    class FinderTest < Minitest::Test
      extend T::Sig
      sig { returns(Ffprober::Ffmpeg::Finder) }
      def test_finder
        Ffprober::Ffmpeg::Finder.new
      end

      sig { returns(TrueClass) }
      def test_executable_name
        assert 'ffprobe', test_finder.executable_name
      end
    end
  end
end
