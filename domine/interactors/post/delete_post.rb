module Interactors
  class DeletePost < Utils::Interactor
    def exec
      req_post = self.request[:post]
      post = PostRepository.find(id: req_post[:id])
      return respond_with_error(:not_found, {resource: 'Post'}) unless post
      PostRepository.destroy(post: post)
      respond_with_success(nil)
    end
  end
end
