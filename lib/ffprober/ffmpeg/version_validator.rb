# typed: strict
# frozen_string_literal: true

module Ffprober
  module Ffmpeg
    class VersionValidator
      extend T::Sig

      MIN_VERSION = T.let(Gem::Version.new('0.9.0'), Gem::Version)

      sig { params(ffmpeg_version: Ffprober::Ffmpeg::Version).void }
      def initialize(ffmpeg_version)
        @ffmpeg_version = ffmpeg_version
      end

      sig { returns(T::Boolean) }
      def valid?
        ffmpeg_version.nightly? || version_requirement_statisfied?
      end

      private

      sig { returns(T::Boolean) }
      def version_requirement_statisfied?
        ffmpeg_version.version >= MIN_VERSION
      end

      sig { returns(Ffprober::Ffmpeg::Version) }
      attr_reader :ffmpeg_version
    end
  end
end
