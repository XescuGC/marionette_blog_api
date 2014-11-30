module Helpers
  module Factories
    class Post
      class << self
        include FactoryGirl::Syntax::Methods
        def new_request
          {post: attributes_for(:post)}
        end
      end
    end
  end
end
