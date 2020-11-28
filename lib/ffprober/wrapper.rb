# frozen_string_literal: true

module Ffprober
  class Wrapper
    attr_reader :json

    def initialize(json)
      raise FfprobeError, json[:error] if json[:error]

      @json = json
    end

    def format
      @format ||= Format.new(json[:format])
    end

    def video_streams
      @video_streams ||= stream_by_codec('video').map do |data|
        VideoStream.new(data)
      end
    end

    def audio_streams
      @audio_streams ||= stream_by_codec('audio').map do |data|
        AudioStream.new(data)
      end
    end

    def data_streams
      @data_streams ||= stream_by_codec('data').map do |data|
        DataStream.new(data)
      end
    end

    def chapters
      @chapters ||= json[:chapters].map { |chapter| Chapter.new(chapter) }
    end

    def subtitle_streams
      @subtitle_streams ||= stream_by_codec('subtitle').map do |stream|
        SubtitleStream.new(stream)
      end
    end

    private

    def stream_by_codec(codec_type)
      streams.select { |stream| stream[:codec_type] == codec_type }
    end

    def streams
      json[:streams]
    end
  end
end
