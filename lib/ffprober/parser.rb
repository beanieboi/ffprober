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
      @video_json = JSON.parse(json_to_parse, symbolize_names: true)
    end

    def format
      Ffprober::Format.new(@video_json[:format])
    end

    def video_streams
      @video_json[:streams].select { |stream| stream[:codec_type] == 'video'}.map do |s|
        Ffprober::VideoStream.new(s)
      end
    end

    def audio_streams
      @video_json[:streams].select { |stream| stream[:codec_type] == 'audio'}.map do |s|
        Ffprober::AudioStream.new(s)
      end
    end

  end
end
