module Utils
  # This Class is the basic error represents one Error
  class Error
    include Utils::ToHash
    attr_accessor :code, :resource, :field
    def initialize(code:, resource:, field:)
      self.code         = code
      self.resource     = resource
      self.field        = field
    end
  end

  # This Class is the formatter for the errors,
  # it represents all the Errors of a Object
  class Errors
    include Utils::ToHash
    attr_accessor :errors, :message
    DEFAULTS = {
      message: 'Check validation errors'
    }

    def initialize(message:, errors:)
      if errors.is_a?(Array)
        self.errors   = errors
        self.message  = message || DEFAULTS[:message]
      else
        raise 'The errors field is not an array'
      end
    end

    # To check if it has errors (used in the Interactor)
    def errors?
      true
    end

    class << self
      # Creates all the structure for the Errors of the Oject
      def create_error_from_object(object, options={})
        errors = []
        object.errors.messages.each do |k, v|
          errors << Error.new(code: error_code(object, k, v), resource: object.class.to_s, field: k)
        end
        new(message: (options[:message] || DEFAULTS[:messasge]), errors: errors)
      end

      # Created all the structure for one error
      def create_custom_error(error_sym, options={})
        error_options = Codes.find_code(error_sym)
        error = Error.new(code: error_options[:code], resource: options[:resource], field: options[:field])
        new(message: (options[:message] || error_options[:message] || DEFAULTS[:message]), errors: [error])
      end

      # Retrives the error code of the object field
      def error_code(object, field, error)
        Codes.matching_error_code(object, field)
      end
    end
  end
end
