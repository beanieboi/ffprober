# frozen_string_literal: true

require_relative 'ffprober/version'

autoload :JSON, 'json'

module Ffprober
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
