module MarionetteBlog
  class Posts < Grape::API
    format :json

    resource :posts do
      get do
        status 200
        posts = Interactors::ListPost.new.exec
        PostDecorator.decorate_response(posts)
      end
    end
  end
end
