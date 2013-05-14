module Ffprober
  class FfprobeVersion
    @@version_regex = /^ffprobe version (\d+)\.?(\d+)\.?(|\d+)$/

    MIN_VERSION = Gem::Version.new("0.9.0")
    MAX_VERSION = Gem::Version.new("1.2.0")

    def self.valid?
      MIN_VERSION <= parsed_version && parsed_version <= MAX_VERSION
    end

    def self.parsed_version
      version = `#{Ffprober.path} -version`.match(@@version_regex)
      raise Errno::ENOENT  if version.nil?
      major, minor, patch = version[1].to_i, version[2].to_i, version[3].to_i
      Gem::Version.new([major, minor, patch].join("."))
    rescue Errno::ENOENT => e
      Gem::Version.new("0.0.0")
    end
  end
end
