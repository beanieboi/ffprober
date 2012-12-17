module Ffprober
  class Parser
    @@options = '-v quiet -print_format json -show_format -show_streams'
    @@version_regex = /^ffprobe version (?:(\d+)\.)?(?:(\d+)\.)?(\*|\d+)$/

    class << self
      def from_file(file_to_parse)
        unless ffprobe_version_valid?
          raise ArgumentError.new("no or unsupported ffprobe version found.\
                                  (version: #{ffprobe_version})")
        end

        json_output = `#{ffprobe_path} #{@@options} #{file_to_parse}`
        from_json(json_output)
      end

      def from_json(json_to_parse)
        parser = self.new
        parser.parse(json_to_parse)
        parser
      end

      def ffprobe_version_valid?
        valid_versions.include?(ffprobe_version)
      end

      def ffprobe_version
        version = `#{ffprobe_path} -version`.match(@@version_regex)
        raise Errno::ENOENT  if version.nil?
        major, minor, patch = version[1].to_i, version[2].to_i, version[3].to_i
        {major: major, minor: minor, patch: patch}
      rescue Errno::ENOENT => e
        {major: 0, minor: 0, patch: 0}
      end

      def valid_versions
        [{major: 0, minor: 9, patch: 0},
         {major: 0, minor: 10, patch: 0},
         {major: 0, minor: 11, patch: 0},
         {major: 1, minor: 0, patch: 0},
		 {major: 1, minor: 0, patch: 1}]
      end

      def ffprobe_path
        name = 'ffprobe'

        if File.executable? name
          cmd
        else
          path = ENV['PATH'].split(File::PATH_SEPARATOR).find { |path|
            File.executable? File.join(path, name)
          }
          path && File.expand_path(name, path)
        end
      end
    end

    def parse(json_to_parse)
      raise ArgumentError.new("No JSON found") if json_to_parse.nil?
      @video_json = MultiJson.load(json_to_parse, :symbolize_keys => true)
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
