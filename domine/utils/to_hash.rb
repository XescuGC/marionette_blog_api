module Utils
  module ToHash
    def to_hash
      instance_variables.inject({}) do |hash, var|
        value = instance_variable_get(var)
        if value.is_a?(Array)
          value = value.map(&:to_hash) rescue value
        end
        hash[var.to_s.delete('@').to_sym] = value
        hash
      end
    end
  end
end
