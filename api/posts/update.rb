module MarionetteBlog
  # Class that defines the PostUpdate API
  class PostsUpdate < Grape::API
    desc 'Call to Update a Post'
    params do
      requires :post, type: Hash do
        optional :title,   type: String
        optional :body,    type: String
        optional :preface, type: String
        optional :tags,    type: Array
      end
    end
    put do
      post_params = params[:post]
      post_params[:id] = params[:id]
      post = Interactors::UpdatePost.new(post: post_params).exec
      status correct_status(post, 200)
      PostDecorator.decorate_response(post)
    end
  end
end
