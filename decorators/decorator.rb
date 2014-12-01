class Decorator
  class << self
    attr_accessor :resource
    def decorate_response(response)
      return nil if response.nil?
      if !response.key?(:errors)
        key = _correct_key(response)
          entity = response.fetch(key)
        if entity.is_a?(Array)
          entity.map{ |r| self.decorate(r)} rescue []
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

    def _correct_key(response)
      if response.key?(self.resource)
        self.resource
      elsif response.key?(resource.to_s.pluralize.to_sym)
        self.resource.to_s.pluralize.to_sym
      else
        raise "Key #{self.resource} && #{self.resource.to_s.pluralize} not found"
      end
    end
  end
end
