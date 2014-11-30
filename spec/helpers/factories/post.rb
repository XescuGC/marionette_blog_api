module Helpers
  module Factories
    class Post
      class << self
        include FactoryGirl::Syntax::Methods
        def new_request
          {post: attributes_for(:post)}
        end

        def new_created_request
          Interactors::CreatePost.new(self.new_request).exec
        end
      end
    end
  end
end
