# typed: strict
# frozen_string_literal: true

module Ffprober
  module Ffmpeg
    class Version
      extend T::Sig

      sig {params(ffprobe_exec: T.any(Ffprober::Ffmpeg::Exec, Ffprober::Ffmpeg::VersionTest::FakeExec)).void}
      def initialize(ffprobe_exec = Ffprober::Ffmpeg::Exec.new)
        @ffprobe_exec = ffprobe_exec
      end

      VERSION_REGEX = /^(ffprobe|avprobe|ffmpeg) version (\d+)\.?(\d+)\.?(\d+)*/
      NIGHTLY_REGEX = /^(ffprobe|avprobe|ffmpeg) version (N|git)-/
      VERSION_FALLBACK = T.let([0, 0, 0].freeze, T::Array[Integer])

      sig {returns(Gem::Version)}
      def version
        @version ||= Gem::Version.new(parse_version.join('.'))
      end

      sig {returns(T::Boolean)}
      def nightly?
        !(ffprobe_version_output =~ NIGHTLY_REGEX).nil?
      end

      private

      sig { returns(T::Array[Integer]) }
      def parse_version
        @parse_version ||= begin
          ffprobe_version_output.match(VERSION_REGEX) do |match|
            [match[2].to_i, match[3].to_i, match[4].to_i]
          end || VERSION_FALLBACK
        end
      end

      sig {returns(String)}
      def ffprobe_version_output
        @ffprobe_exec.ffprobe_version_output
      end

      sig {returns(String)}
      def to_s
        parse_version.join('.')
      end
    end
  end
end
