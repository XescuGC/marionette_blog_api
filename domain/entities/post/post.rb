# This is the Entity Pos  representation with Virtus,
# it defines the attributes it has, the validations and the methods
class Post
  include Virtus.model
  include ActiveModel::Validations
  include ActiveModel::Model

  include UpdateAttributes

  attribute :id,          BSON::ObjectId
  attribute :title,       String
  attribute :tags,        Array[Tag]
  attribute :created_at,  Time
  attribute :updated_at,  Time
  attribute :body,        String
  attribute :preface,     String

  validates :title, :created_at, :updated_at, :body, :preface, presence: true
end
