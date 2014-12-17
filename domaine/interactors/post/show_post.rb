module Interactors
  # This Interactors is in charge of Showing a Post,
  # it expects a Hash object like this:
  #   {
  #     post: {
  #       id: '123'
  #     }
  #   }
  #
  # It will return an error Hash or a Hash with the Post
  class ShowPost < Utils::Interactor
    def exec
      req_post = self.request[:post]
      post = PostRepository.find(id: req_post[:id])
      return respond_with_error(:not_found, resource: 'Post') unless post
      respond_with_success(post)
    end
  end
end
