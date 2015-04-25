module Ffprober
  class FfprobeVersion
    def self.valid?
      self.new.valid?
    end

    def valid?
      validator.valid?
    end

    private

    def validator
      Ffprober::Ffmpeg::VersionValidator.new(version)
    end

    def version
      Ffprober::Ffmpeg::Version.new
    end
  end
end
