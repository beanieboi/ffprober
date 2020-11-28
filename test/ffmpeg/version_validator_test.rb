# typed: true
# frozen_string_literal: true

require 'test_helper'

module Ffprober
  module Ffmpeg
    class VersionValidatorTest < Minitest::Test
      def test_valid
        version = Ffprober::Ffmpeg::Version.new
        Ffprober::Ffmpeg::VersionValidator.new(version)
      end
    end
  end
end
