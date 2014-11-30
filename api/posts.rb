module MarionetteBlog
  class Posts < Grape::API
    format :json

    resource :posts do
      get do
        status 200
        posts = Interactors::ListPost.new.exec
        PostDecorator.decorate_response(posts)
      end
      post do
        status 201
        post = Interactors::CreatePost.new({post: params[:post]}).exec
        PostDecorator.decorate_response(post)
      end
    end
  end
end
