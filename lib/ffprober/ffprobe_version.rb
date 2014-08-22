module Ffprober
  class FfprobeVersion
    VERSION_REGEX = /^(ffprobe|avprobe|ffmpeg) version (\d+)\.?(\d+)\.?(\d+)*/
    NIGHTLY_REGEX = /^(ffprobe|avprobe|ffmpeg) version (N|git)-/

    MIN_VERSION = Gem::Version.new('0.9.0')
    MAX_VERSION = Gem::Version.new('2.3.2')

    def self.valid?
      new.valid?
    end

    def self.version
      new.version
    end

    def valid?
      nightly? || (MIN_VERSION <= version && version <= MAX_VERSION)
    end

    def parse_version
      @parse_version ||= begin
        ffprobe_version_output.match(VERSION_REGEX) do |match|
          [match[2].to_i, match[3].to_i, match[4].to_i]
        end || [0, 0, 0]
      end
    end

    def version
      @version ||= Gem::Version.new(parse_version.join('.'))
    end

    def nightly?
      !!(ffprobe_version_output =~ NIGHTLY_REGEX)
    end

    def ffprobe_version_output
      @ffprobe_version_output ||= Ffprober.path.nil? ? '' : `#{Ffprober.path} -version`
    end
  end
end
