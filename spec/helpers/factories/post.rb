module Helpers
  module Factories
    class Post
      class << self
        include FactoryGirl::Syntax::Methods
        def new_request(opts={})
          if opts[:tags]
            {post: attributes_for(:post, tags: opts[:tags])}
          else
            {post: attributes_for(:post)}
          end
        end

        def new_created_request(opts={})
          Interactors::CreatePost.new(self.new_request(opts)).exec
        end
      end
    end
  end
end
