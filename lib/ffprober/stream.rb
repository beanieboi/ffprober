module Ffprober
  class Stream
    attr_accessor :codec_name, :codec_long_name, :codec_type,
                  :codec_time_base, :codec_tag_string, :codec_tag,
                  :r_frame_rate, :avg_frame_rate,
                  :time_base, :start_time, :duration,
                  :nb_frames

    def initialize(object_attribute_hash)
      object_attribute_hash.map do |(k, v)|
        writer_m = "#{k}="
        send(writer_m, v) if respond_to?(writer_m)
      end
    end
  end
end
