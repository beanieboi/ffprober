module Ffprober
  class Wrapper
    attr_reader :json

    def initialize(json)
      @json = json
    end

    def format
      @format ||= Ffprober::Format.new(json[:format])
    end

    def video_streams
      @video_streams ||= stream_by_codec('video').map do |data|
        Ffprober::VideoStream.new(data)
      end
    end

    def audio_streams
      @audio_streams ||= stream_by_codec('audio').map do |data|
        Ffprober::AudioStream.new(data)
      end
    end

    def data_streams
      @data_streams ||= stream_by_codec('data').map do |data|
        Ffprober::DataStream.new(data)
      end
    end

    def chapters
      @chapters ||= json[:chapters].map do |chapter|
        Ffprober::Chapter.new(chapter)
      end
    end

    def subtitle_streams
      @subtitle_streams ||= stream_by_codec('subtitle').map do |stream|
        Ffprober::SubtitleStream.new(stream)
      end
    end

    private

    def stream_by_codec(codec_type)
      streams.select { |stream| stream[:codec_type] == codec_type }
    end

    def streams
      json[:streams]
    end

    attr_reader :json
  end
end
