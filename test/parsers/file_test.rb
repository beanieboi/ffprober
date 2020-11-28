# typed: true
# frozen_string_literal: true

require 'test_helper'

module Ffprober
  module Parsers
    class FileParserTest < Minitest::Test
      extend T::Sig
      class FakeExec
        extend T::Sig
        sig { void }
        def initialize
          @json_output = nil
        end

        def json_output(_file_to_parse)
          @json_output || '{}'
        end
      end

      sig { returns(TrueClass) }
      def test_without_file
        assert_raises ArgumentError do
          FileParser.new('not_found.mp4')
        end
      end

      sig { returns(Ffprober::Parsers::JsonParser) }
      def test_with_a_video_file
        fake_exec = FakeExec.new
        video_file = File.join(assets_path, '301 extracting a ruby gem.m4v')
        file = FileParser.new(video_file, fake_exec)
        file.load
      end
    end
  end
end
