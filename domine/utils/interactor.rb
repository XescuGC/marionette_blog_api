module Utils
  # This class is the Parent of all the Interactors and describes the basic methods used for all the Interactors
  class Interactor

    attr_accessor :request

    # It creates the Request object for the Interactor
    def initialize(request_or_hash = { })
      if request_or_hash.is_a?(Hash)
        self.request = Request.try_convert(request_or_hash)
      else
        self.request = request_or_hash
      end
    end

    # Creates a response object
    def create_response(object, options={})
      if (object.errors? rescue nil)
        Utils::Response.create_response_from_object(object)
      else
        Utils::Response.create_response_from_object(object, scope: (options[:scope] || object.class.to_s.underscore))
      end
    end
    alias_method :respond_with_success, :create_response

    # Creates the Error object and then creates a response withit
    def respond_with_error(object, options={})
      errors = nil
      unless object.is_a?(Symbol)
        errors = Utils::Errors.create_error_from_object(object)
      else
        errors = _create_standar_error(object, options)
      end
      create_response(errors)
    end

    def _create_standar_error(error, options={})
      Utils::Errors.create_custom_error(error, options)
    end
  end
end
