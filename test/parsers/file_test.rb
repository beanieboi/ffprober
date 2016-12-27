# frozen_string_literal: true
require 'test_helper'

class Ffprober::Parsers::FileTest < Minitest::Test
  class FakeExec
    attr_writer :json_output
    def json_output(_file_to_parse)
      @json_output || '{}'
    end
  end

  def test_without_file
    assert_raises ArgumentError do
      Ffprober::Parsers::File.new('not_found.mp4')
    end
  end

  def test_with_a_video_file
    fake_exec = FakeExec.new
    video_file = File.join(assets_path, '301 extracting a ruby gem.m4v')
    file = Ffprober::Parsers::File.new(video_file, fake_exec)
    file.load
  end
end
