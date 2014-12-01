module Interactors
  # This Interactors is in charge of Updating a Post, it expects a Hash object with the attributes of the Post
  #   {
  #     post: {
  #       title: 'Title',
  #       body: 'body here',
  #       preface: 'preface here',
  #       tags: [
  #         'surf',
  #         'tag'
  #       ]
  #     }
  #   }
  #
  # It will return an error Hash or a Hash with the Created Post
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
