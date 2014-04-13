module Ffprober
  class Stream
    attr_reader :codec_name, :codec_long_name, :codec_type,
                :codec_time_base, :codec_tag_string, :codec_tag,
                :r_frame_rate, :avg_frame_rate,
                :time_base, :start_time, :duration,
                :nb_frames

    def initialize(object_attribute_hash)
      object_attribute_hash.each { |k, v| instance_variable_set("@#{k}", v) }
    end
  end
end
