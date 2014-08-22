module Ffprober
  class Chapter
    def initialize(object_attribute_hash)
      object_attribute_hash.each do |key, value|
        instance_variable_set("@#{key}", value)

        unless self.class.method_defined?(key)
          self.class.send(:define_method, key) do
            instance_variable_get("@#{key}")
          end
        end
      end
    end
  end
end
