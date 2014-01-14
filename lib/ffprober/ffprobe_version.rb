module Ffprober
  class FfprobeVersion
    @@version_regex = /^(ffprobe|avprobe|ffmpeg) version (\d+)\.?(\d+)\.?(\d+)*/
    @@nightly_regex = /^(ffprobe|avprobe|ffmpeg) version (N|git)-/

    MIN_VERSION = Gem::Version.new("0.9.0")
    MAX_VERSION = Gem::Version.new("2.1.2")

    def self.valid?
      self.new.valid?
    end

    def valid?
      nightly? || (MIN_VERSION <= version && version <= MAX_VERSION)
    end

    def parse_version
      @parse_version ||= begin
        _p = version_output.match(@@version_regex)
        if _p.nil?
          [0, 0, 0]
        else
          [_p[2].to_i, _p[3].to_i, _p[4].to_i]
        end
      end
    end

    def version
      @version ||= Gem::Version.new(parse_version.join("."))
    end

    def nightly?
      !!(version_output =~ @@nightly_regex)
    end

    def version_output
      return "" if Ffprober.path.nil?
      @version_output ||= `#{Ffprober.path} -version`
    end
  end
end
