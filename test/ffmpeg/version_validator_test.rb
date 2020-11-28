# typed: strict
# frozen_string_literal: true

require 'test_helper'

module Ffprober
  module Ffmpeg
    class VersionValidatorTest < Minitest::Test
      extend T::Sig
      sig { returns(Ffprober::Ffmpeg::VersionValidator) }
      def test_valid
        version = Ffprober::Ffmpeg::Version.new
        Ffprober::Ffmpeg::VersionValidator.new(version)
      end
    end
  end
end
