require 'test_helper'

class FfproberTest < Minitest::Test
  def test_json_input
    ffprobe = Ffprober::Parser.from_json(File.read("test/assets/sample video.json"))

    assert_equal "test/assets/sample video.m4v", ffprobe.format.filename

    assert_equal "44100", ffprobe.audio_streams.first.sample_rate
    assert_equal 1, ffprobe.audio_streams.count

    assert_equal 1, ffprobe.subtitle_streams.count
    assert_equal "eng", ffprobe.subtitle_streams.first.tags[:language]

    assert_equal 1, ffprobe.video_streams.count
    assert_equal 480, ffprobe.video_streams.first.width

    assert_equal 3, ffprobe.chapters.count
    assert_equal "1/1000", ffprobe.chapters.first.time_base
  end

  def test_file_input
    ffprobe = Ffprober::Parser.from_file("test/assets/301 extracting a ruby gem.m4v")

    assert_equal "test/assets/301 extracting a ruby gem.m4v", ffprobe.format.filename

    assert_equal "44100", ffprobe.audio_streams.first.sample_rate
    assert_equal 1, ffprobe.audio_streams.count

    assert_equal 0, ffprobe.subtitle_streams.count

    assert_equal 1, ffprobe.video_streams.count
    assert_equal 480, ffprobe.video_streams.first.width

    assert_equal 0, ffprobe.chapters.count
  end
end
