module Ffprober
  module Ffmpeg
    class Version
      VERSION_REGEX = /^(ffprobe|avprobe|ffmpeg) version (\d+)\.?(\d+)\.?(\d+)*/
      NIGHTLY_REGEX = /^(ffprobe|avprobe|ffmpeg) version (N|git)-/

      def version
        @version ||= Gem::Version.new(parse_version.join("."))
      end

      def nightly?
        !!(ffprobe_version_output =~ NIGHTLY_REGEX)
      end

      private

      def parse_version
        @parse_version ||= begin
          ffprobe_version_output.match(VERSION_REGEX) do |match|
            [match[2].to_i, match[3].to_i, match[4].to_i]
          end || [0, 0, 0]
        end
      end

      def ffprobe_version_output
        @ffprobe_version_output ||= ffprobe_finder.path.nil? ? "" : `#{ffprobe_finder.path} -version`
      end

      def ffprobe_finder
        Ffprober::Ffmpeg::Finder
      end

      def to_s
        parse_version.join(".")
      end
    end
  end
end
