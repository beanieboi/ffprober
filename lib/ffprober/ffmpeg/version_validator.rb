# typed: strict
# frozen_string_literal: true

module Ffprober
  module Ffmpeg
    class VersionValidator
      MIN_VERSION = Gem::Version.new('0.9.0')

      def initialize(ffmpeg_version)
        @ffmpeg_version = ffmpeg_version
      end

      def valid?
        ffmpeg_version.nightly? || version_requirement_statisfied?
      end

      private

      def version_requirement_statisfied?
        ffmpeg_version.version >= MIN_VERSION
      end

      attr_reader :ffmpeg_version
    end
  end
end
