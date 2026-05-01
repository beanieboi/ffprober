# typed: true
# frozen_string_literal: true

require 'bundler'
Bundler.setup

require_relative 'ffprober/version'

autoload :JSON, 'json'

module Ffprober
  # Sentinel for "no allowed_schemes argument was passed". Lets us tell the
  # difference between "caller didn't pass the kwarg" (fall back to the
  # global) and "caller explicitly passed nil" (reject loudly).
  module NoScheme; end

  class << self
    def allowed_url_schemes
      @allowed_url_schemes if defined?(@allowed_url_schemes)
    end

    def allowed_url_schemes=(value)
      raise ArgumentError, 'allowed_url_schemes cannot be nil' if value.nil?
      raise ArgumentError, "allowed_url_schemes must be an Array, got #{value.class}" unless value.is_a?(Array)
      raise ArgumentError, 'allowed_url_schemes cannot be empty' if value.empty?

      @allowed_url_schemes = value.dup.freeze
    end
  end

  class EmptyInput < StandardError; end

  class InvalidInputFileError < StandardError; end

  class NoFfprobeFound < StandardError; end

  class UnsupportedVersion < StandardError; end

  class FfprobeError < StandardError
    def initialize(ff_err)
      super("Ffprobe responded with: #{ff_err[:string]} (#{ff_err[:code]})")
    end
  end

  autoload :AudioStream, 'ffprober/audio_stream'
  autoload :Chapter, 'ffprober/chapter'
  autoload :DataStream, 'ffprober/data_stream'
  autoload :DynamicInitializer, 'ffprober/dynamic_initializer'
  autoload :FfprobeVersion, 'ffprober/ffprobe_version'
  autoload :Format, 'ffprober/format'
  autoload :Parser, 'ffprober/parser'
  autoload :Stream, 'ffprober/stream'
  autoload :SubtitleStream, 'ffprober/subtitle_stream'
  autoload :VideoStream, 'ffprober/video_stream'
  autoload :Wrapper, 'ffprober/wrapper'

  module Ffmpeg
    autoload :Exec, 'ffprober/ffmpeg/exec'
    autoload :Finder, 'ffprober/ffmpeg/finder'
    autoload :Version, 'ffprober/ffmpeg/version'
    autoload :VersionValidator, 'ffprober/ffmpeg/version_validator'
  end

  module Parsers
    autoload :FileParser, 'ffprober/parsers/file'
    autoload :UrlParser, 'ffprober/parsers/url'
    autoload :JsonParser, 'ffprober/parsers/json'
  end
end
