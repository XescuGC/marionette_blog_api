module Utils
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
      def matching_error_code(object, field)
        Codes.each do |code|
          return code[:code] if object.errors.added?(field.to_sym, code[:error])
        end
        Codes.find{ |e| e[:error] == :invalid }[:code]
      end
      def find_code(error)
        Codes.find{ |e| e[:error] == error }
      end
    end
  end
end
