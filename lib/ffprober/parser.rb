module Ffprober
  class Parser
    @@options = '-v quiet -print_format json -show_format -show_streams'

    class << self
      def from_file(file_to_parse)
        unless FfprobeVersion.valid?
          raise ArgumentError.new("no or unsupported ffprobe version found.\
                                  (version: #{FfprobeVersion.parsed_version.to_s})")
        end

        json_output = `#{Ffprober.path} #{@@options} #{file_to_parse}`
        from_json(json_output)
      end

      def from_json(json_to_parse)
        parser = self.new
        parser.parse(json_to_parse)
        parser
      end
    end

    def parse(json_to_parse)
      raise ArgumentError.new("No JSON found") if json_to_parse.nil?
      @json_to_parse = json_to_parse
    end

    def parsed_json
      @parsed_json ||=  begin
                          json = JSON.parse(@json_to_parse, symbolize_names: true)
                          raise StandardError.new("Invalid input file") if json.empty?
                          json
                        end
    end

    def format
      @format ||= Ffprober::Format.new(parsed_json[:format])
    end

    def video_streams
      @video_streams ||= stream_by_codec('video').map { |s| Ffprober::VideoStream.new(s) }
    end

    def audio_streams
      @audio_streams ||= stream_by_codec('audio').map { |s| Ffprober::AudioStream.new(s) }
    end

    def stream_by_codec(codec_type)
      streams.select { |stream| stream[:codec_type] == codec_type }
    end

    def streams
      parsed_json[:streams]
    end
  end
end
