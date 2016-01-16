require 'test_helper'

class Ffprober::Ffmpeg::ExecTest < Minitest::Test
  class FakeFinder
    attr_writer :path
    def path
      @path
    end
  end

  def test_output_without_ffmpeg
    finder = FakeFinder.new
    finder.path = nil
    exec = Ffprober::Ffmpeg::Exec.new(finder)
    assert "", exec.ffprobe_version_output
  end

  def test_output_with_ffmpeg
    finder = FakeFinder.new
    finder.path = fake_ffprobe_version_path
    exec = Ffprober::Ffmpeg::Exec.new(finder)
    assert_equal "fake_version_output\n", exec.ffprobe_version_output
  end

  def test_json_output
    finder = FakeFinder.new
    finder.path = fake_ffprobe_output_path
    exec = Ffprober::Ffmpeg::Exec.new(finder)
    assert_equal "fake_version_output\n", exec.json_output(nil)
  end
end
