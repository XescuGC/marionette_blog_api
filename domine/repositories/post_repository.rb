class PostRepository
  Perpetuity.generate_mapper_for Tag do
    attribute :name
  end

  Perpetuity.generate_mapper_for Post do
    attribute :id
    attribute :title
    attribute :created_at
    attribute :updated_at
    attribute :body
    attribute :preface

    attribute :tags,        embedded: true
  end

  class << self
    def repo
      Perpetuity[Post]
    end

    def all
      self.repo.all.to_a
    end

    def create(post:)
      post.id = self.repo.insert(post)
      post
    end
  end
end
