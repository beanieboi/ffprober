# typed: strict
# frozen_string_literal: true

module Ffprober
  module Ffmpeg
    class Version
      extend T::Sig

      sig { params(ffprobe_exec: T.any(Ffprober::Ffmpeg::Exec, T.untyped)).void }
      def initialize(ffprobe_exec = Ffprober::Ffmpeg::Exec.new)
        @ffprobe_exec = ffprobe_exec
        @version = T.let(nil, T.nilable(Gem::Version))
        @parse_version = T.let(nil, T.nilable(T::Array[Integer]))
      end

      VERSION_REGEX = T.let(/^(ffprobe|avprobe|ffmpeg) version (\d+)\.?(\d+)\.?(\d+)*/.freeze, Regexp)
      NIGHTLY_REGEX = T.let(/^(ffprobe|avprobe|ffmpeg) version (N|git)-/.freeze, Regexp)
      VERSION_FALLBACK = T.let([0, 0, 0].freeze, T::Array[Integer])

      sig { returns(Gem::Version) }
      def version
        @version ||= Gem::Version.new(parse_version.join('.'))
      end

      sig { returns(T::Boolean) }
      def nightly?
        !(ffprobe_version_output =~ NIGHTLY_REGEX).nil?
      end

      private

      sig { returns(T::Array[Integer]) }
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

      sig { returns(String) }
      def ffprobe_version_output
        @ffprobe_exec.ffprobe_version_output
      end

      sig { returns(String) }
      def to_s
        parse_version.join('.')
      end
    end
  end
end
