require 'singleton'

module Ffprober
  class FfprobeVersion
    include Singleton

    @@version_regex = /^ffprobe version (\d+)\.?(\d+)\.?(|\d+)$/

    MIN_VERSION = Gem::Version.new("0.9.0")
    MAX_VERSION = Gem::Version.new("1.2.1")

    def self.valid?
      self.instance.valid?
    end

    def valid?
      MIN_VERSION <= version && version <= MAX_VERSION
    end

    def parsed_version
      @parsed_version ||= begin
        _p = version_output.match(@@version_regex)
        if _p.nil?
          [0, 0, 0]
        else
          [_p[1].to_i, _p[2].to_i, _p[3].to_i]
        end
      end
    end

    def version
      @version ||= Gem::Version.new(parsed_version.join("."))
    end

    def version_output
      @version_output ||= `#{Ffprober.path} -version`
    end
  end
end
