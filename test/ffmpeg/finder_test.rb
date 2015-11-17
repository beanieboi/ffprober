require 'test_helper'

class Ffprober::Ffmpeg::FinderTest < Minitest::Test
  def test_finder
    finder = Ffprober::Ffmpeg::Finder.new
  end

  def test_executable_name
    assert "ffprobe", Ffprober::Ffmpeg::Finder.executable_name
  end
end
