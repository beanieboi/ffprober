module Ffprober
  class Format
    attr_accessor :filename, :nb_streams, :format_name,
                  :format_long_name, :start_time, :duration,
                  :size, :bit_rate

    def initialize(object_attribute_hash)
      object_attribute_hash.map do |(k, v)|
        writer_m = "#{k}="
        send(writer_m, v) if respond_to?(writer_m)
      end
    end
  end
end
