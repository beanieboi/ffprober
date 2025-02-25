# typed: strict
# frozen_string_literal: true

module Ffprober
  class Parser
    def self.from_file(file_to_parse)
      check_version

      raise EmptyInput, file_to_parse if File.empty?(file_to_parse)

      file_parser = Parsers::FileParser.new(file_to_parse)
      json_parser = file_parser.load
      Ffprober::Wrapper.new(json_parser.json)
    end

    def self.from_url(url_to_parse)
      check_version

      url_parser = Parsers::UrlParser.new(url_to_parse)
      json_parser = url_parser.load
      Ffprober::Wrapper.new(json_parser.json)
    end

    def self.from_json(json_to_parse)
      json_parser = Parsers::JsonParser.new(json_to_parse)
      Ffprober::Wrapper.new(json_parser.json)
    end

    def self.check_version
      msg = "found version: #{FfprobeVersion.version}"
      raise UnsupportedVersion, msg if FfprobeVersion.invalid?
    end
  end
end
