module UpdateAttributes
  def update_attributes(attrs)
    attrs.each do |k, v|
      self.send("#{k}=", v) if self.send("#{k}") != v rescue nil
    end
  end
end

