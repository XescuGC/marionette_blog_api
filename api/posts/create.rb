module MarionetteBlog
  class PostsCreate < Grape::API
    params do
      requires :post, type: Hash do
        requires :title,   type: String
        requires :body,    type: String
        requires :preface, type: String
        requires :tags,    type: Array
      end
    end
    post do
      post = Interactors::CreatePost.new({post: params[:post]}).exec
      status correct_status(post, 201)
      PostDecorator.decorate_response(post)
    end
  end
end
