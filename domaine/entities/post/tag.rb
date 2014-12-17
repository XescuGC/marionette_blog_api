# This is the Tag Entity/Model representation with Virtus,
# it defines the attributes it has, the validations and the methods
class Tag
  include Virtus.model
  include ActiveModel::Validations
  include ActiveModel::Model

  attribute :name

  validates :name, presence: true
end
