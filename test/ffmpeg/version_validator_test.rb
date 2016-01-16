require 'test_helper'

class Ffprober::Ffmpeg::VersionValidatorTest < Minitest::Test
  def test_valid
    version = Ffprober::Ffmpeg::Version.new
    validator = Ffprober::Ffmpeg::VersionValidator.new(version)
  end
end
