# frozen_string_literal: true
module Ffprober
  class FfprobeVersion
    def self.invalid?
      !new.valid?
    end

    def self.valid?
      new.valid?
    rescue NoFfprobeFound
      false
    end

    def valid?
      validator.valid?
    end

    def self.version
      new.version
    end

    def version
      Ffprober::Ffmpeg::Version.new
    end

    private

    def validator
      Ffprober::Ffmpeg::VersionValidator.new(version)
    end
  end
end
