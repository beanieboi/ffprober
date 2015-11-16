require_relative "ffprober/version"
require_relative "ffprober/dynamic_initializer"
require_relative "ffprober/parser"
require_relative "ffprober/format"
require_relative "ffprober/stream"
require_relative "ffprober/audio_stream"
require_relative "ffprober/data_stream"
require_relative "ffprober/video_stream"
require_relative "ffprober/subtitle_stream"
require_relative "ffprober/chapter"
require_relative "ffprober/ffprobe_version"
require_relative "ffprober/wrapper"
require_relative "ffprober/errors"

require_relative "ffprober/ffmpeg/finder"
require_relative "ffprober/ffmpeg/version"
require_relative "ffprober/ffmpeg/version_validator"
require_relative "ffprober/parsers/file"
require_relative "ffprober/parsers/json"
require "json"

module Ffprober
  class NoFfprobeFound < StandardError; end
  class UnsupportedVersion < StandardError; end
  class EmptyInput < StandardError; end
end
