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

    def find(id:)
      begin
        id = BSON::ObjectId.from_string(id) if id.is_a?(String)
        self.repo.find(id)
      rescue
        return nil
      end
    end

    def update(post:)
      self.repo.save(post)
    end

    def all
      self.repo.all.sort(:created_at).reverse.to_a
    end

    def create(post:)
      post.id = self.repo.insert(post)
      post
    end

    def find_all_with_tag(tag:)
      self.repo.custom({'tags.name' => tag}).sort(:created_at).reverse.to_a
    end

    def destroy(post:)
      self.repo.delete(post)
    end
  end
end
