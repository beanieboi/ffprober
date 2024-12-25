# typed: strict
# frozen_string_literal: true

module Ffprober
  module Ffmpeg
    class Version
      def initialize(ffprobe_exec = Ffprober::Ffmpeg::Exec.new)
        @ffprobe_exec = ffprobe_exec
        @version = nil
        @parse_version = nil
      end

      VERSION_REGEX = /^(ffprobe|avprobe|ffmpeg) version (\d+)\.?(\d+)\.?(\d+)*/
      NIGHTLY_REGEX = /^(ffprobe|avprobe|ffmpeg) version (N|git)-/
      VERSION_FALLBACK = [0, 0, 0].freeze

      def version
        @version ||= Gem::Version.new(parse_version.join('.'))
      end

      def nightly?
        !(ffprobe_version_output =~ NIGHTLY_REGEX).nil?
      end

      private

      def parse_version
        return @parse_version if @parse_version

        match_data = ffprobe_version_output.match(VERSION_REGEX)

        @parse_version = if match_data
                           [match_data[2].to_i, match_data[3].to_i, match_data[4].to_i]
                         else
                           VERSION_FALLBACK
                         end

        @parse_version
      end

      def ffprobe_version_output
        @ffprobe_exec.ffprobe_version_output
      end

      def to_s
        parse_version.join('.')
      end
    end
  end
end
