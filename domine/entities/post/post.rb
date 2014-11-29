class Post
  include Virtus.model
  include ActiveModel::Validations
  include ActiveModel::Model

  attribute :id,          BSON::ObjectId
  attribute :title,       String
  attribute :tags,        Array[Tag]
  attribute :created_at,  Time
  attribute :updated_at,  Time
  attribute :body,        String
  attribute :preface,     String
end
