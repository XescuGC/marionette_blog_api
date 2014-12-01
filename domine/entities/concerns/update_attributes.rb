# This module adds the methos needed to update a Object:
#   obj.update_attributes(hash)
module UpdateAttributes

  # This method expects some attributes to update the main object with them
  def update_attributes(attrs)
    attrs.each do |k, v|
      self.send("#{k}=", v) if self.send("#{k}") != v rescue nil
    end
  end
end

