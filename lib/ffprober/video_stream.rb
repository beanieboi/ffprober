module Ffprober
  class VideoStream < Stream
    attr_accessor :width, :height, :has_b_frames,
                  :sample_aspect_ratio, :display_aspect_ratio,
                  :pix_fmt, :level, :is_avc, :nal_length_size, :bit_rate
  end
end
