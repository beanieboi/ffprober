module Ffprober
  class Format
    attr_reader :filename, :nb_streams, :format_name,
                :format_long_name, :start_time, :duration,
                :size, :bit_rate

    def initialize(object_attribute_hash)
      object_attribute_hash.each { |k, v| instance_variable_set("@#{k}", v) }
    end
  end
end
