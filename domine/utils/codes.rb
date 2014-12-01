module Utils
  # This class contains all the error codes specification
  class Codes
    Codes = [
      {code: 100, error: :blank_resource },
      {code: 101, error: :blank },
      {code: 102, error: :invalid },
      {code: 103, error: :taken },
      {code: 104, error: :no_auth },
      {code: 105, error: :not_found },
      {code: 106, error: :unauthorized, message: 'Unauthorized Person Role' }
    ]
    class << self
      # Returns the error code of the field within the object
      def matching_error_code(object, field)
        Codes.each do |code|
          return code[:code] if object.errors.added?(field.to_sym, code[:error])
        end
        Codes.find{ |e| e[:error] == :invalid }[:code]
      end

      # Find the error Hash with the error Symbol name
      def find_code(error)
        Codes.find{ |e| e[:error] == error }
      end
    end
  end
end
