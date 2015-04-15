module Utils
  # This Class is used to convert the objects of the Domine in Hash objects,
  # raw data, to then be accessibles for the rest of the app
  # it serializes the object to convert it to a Hash
  class Response < Hash
    class << self
      def create_response_from_object(obj, options={})
        return obj if obj.nil?
        hash_obj = if obj.is_a?(Array)
                     obj.map(&:to_hash).each do |item|
                       _object_to_hash(item)
                     end
                   else
                     _object_to_hash(obj.to_hash)
                   end
        if options[:scope]
          return self.try_convert(eval(%Q({#{options[:scope]}: hash_obj})))
        else
          return self.try_convert(hash_obj)
        end
      end

      def _object_to_hash(obj)
        obj.each do |item|
          if ingnore_types.include?(item[1].class)
            next
          else
            obj[item[0]] = serialize(item[1])
          end
        end
        obj
      end

      def _array_to_hash(array)
        array.map do |item|
          if ingnore_types.include?(item.class)
            next
          else
            serialize(item, from: :array)
          end
        end
      end

      def serialize(value, options={})
        if serializable_types.include?(value.class)
          value
        elsif value.is_a?(Array)
          _array_to_hash(value)
        elsif value.is_a?(BSON::ObjectId)
          value.to_s
        elsif value.is_a?(Perpetuity::Reference)
          if options[:from] == :array
            { id: value.id.to_s }
          else
            value.id.to_s
          end
        else
          create_response_from_object(value)
        end
      end

      def serializable_types
        [Symbol, NilClass, TrueClass, FalseClass, Fixnum, Float, String, Hash, Time]
      end

      def ingnore_types
        [Virtus::AttributeSet, ActiveModel::Errors]
      end
    end
  end
end
