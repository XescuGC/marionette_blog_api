module Interactors
  # This Interactors is in charge of Creating a new Post,
  # it expects a Hash object with the attributes of the Post
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
  class CreatePost < Utils::Interactor
    def exec
      req_post = self.request[:post]
      tags = req_post[:tags].map { |t| Tag.new(name: t) }
      post = Post.new(
        title:      req_post[:title],
        created_at: Time.now.utc,
        updated_at: Time.now.utc,
        body:       req_post[:body],
        preface:    req_post[:preface],
        tags:       tags
      )
      if post.valid?
        post = PostRepository.create(post: post)
        self.respond_with_success(post)
      else
        self.respond_with_error(post)
      end
    end
  end
end
