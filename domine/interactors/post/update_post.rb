module Interactors
  class UpdatePost < Utils::Interactor
    def exec
      req_post = self.request[:post]
      post = PostRepository.find(id: req_post[:id])
      return respond_with_error(:not_found, {resource: 'Post'}) unless post
      post.update_attributes(req_post)
      post.updated_at = Time.now.utc
      if post.valid?
        PostRepository.update(post: post)
        respond_with_success(post)
      else
        respond_with_error(post)
      end
    end
  end
end
