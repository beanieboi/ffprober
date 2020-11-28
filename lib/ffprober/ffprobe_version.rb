# typed: strict
# frozen_string_literal: true

module Ffprober
  class FfprobeVersion
    extend T::Sig

    sig { returns(T::Boolean) }
    def self.invalid?
      !new.valid?
    end

    sig { returns(T::Boolean) }
    def self.valid?
      new.valid?
    rescue NoFfprobeFound
      false
    end

    sig { returns(T::Boolean) }
    def valid?
      validator.valid?
    end

    sig { returns(Ffprober::Ffmpeg::Version) }
    def self.version
      new.version
    end

    sig { returns(Ffprober::Ffmpeg::Version) }
    def version
      Ffprober::Ffmpeg::Version.new
    end

    private

    sig { returns(Ffprober::Ffmpeg::VersionValidator) }
    def validator
      Ffprober::Ffmpeg::VersionValidator.new(version)
    end
  end
end
