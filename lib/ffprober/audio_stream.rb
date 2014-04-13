module Ffprober
  class AudioStream < Stream
    attr_accessor :sample_fmt, :sample_rate, :channels,
                  :bits_per_sample
  end
end
