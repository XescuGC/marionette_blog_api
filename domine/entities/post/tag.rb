class Tag
  include Virtus.model
  include ActiveModel::Validations
  include ActiveModel::Model

  attribute :name

  validates :name, presence: true
end
