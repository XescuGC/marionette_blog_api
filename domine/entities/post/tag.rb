class Tag
  include Virtus.model
  include ActiveModel::Validations
  include ActiveModel::Model

  attribute :name
end
