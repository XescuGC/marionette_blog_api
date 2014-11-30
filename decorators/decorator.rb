class Decorator
  class << self
    attr_accessor :resource
    def decorate_response(response)
      if !response.key?(:errors)
        entity = response.fetch(self.resource)
        if entity.is_a?(Array)
          entity.map{ |r| self.decorate(r)}# rescue []
        else
          self.decorate(entity)
        end
      else
        return {
          message:  response[:message],
          errors:   response[:errors].map{ |r| self.decorate_error(r)}
        }
      end
    end

    def decorate_error(error)
      {
        resource: error[:resource],
        field:    error[:field],
        code:     error[:code]
      }
    end
  end
end
