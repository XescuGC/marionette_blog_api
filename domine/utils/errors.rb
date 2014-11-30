module Utils

  class Error
    include Utils::ToHash
    attr_accessor :code, :resource, :field
    def initialize(code:, resource:, field:)
      self.code         = code
      self.resource     = resource
      self.field        = field
    end
  end

  class Errors
    include Utils::ToHash
    attr_accessor :errors, :message
    Defaults = {
      message: 'Check validation errors'
    }

    def initialize(message:, errors:)
      if errors.is_a?(Array)
        self.errors   = errors
        self.message  = message || 'Chech the errors'
      else
        raise 'The errors field is not an array'
      end
    end

    def errors?
      true
    end

    class << self
      def create_error_from_object(object, options={})
        errors = []
        object.errors.messages.each do |k, v|
          errors << Error.new(code: error_code(object,k,v), resource: object.class.to_s, field: k)
        end
        new(message: (options[:message] || Defaults[:messasge]), errors: errors)
      end

      def create_custom_error(error_sym, options={})
        error_options = Codes.find_code(error_sym)
        error = Error.new(code: error_options[:code], resource: options[:resource], field: options[:field])
        new(message: (options[:message] || error_options[:message] || Defaults[:message]), errors: [error])
      end

      def error_code(object, field, error)
        Codes.matching_error_code(object, field)
      end
    end
  end
end
