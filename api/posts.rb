module MarionetteBlog
  # Class that defines all the API calls
  # to interact with the Posts
  class Posts < Grape::API
    format :json

    resource :posts do
      mount MarionetteBlog::PostsList
      mount MarionetteBlog::PostsCreate
      route_param :id do
        mount MarionetteBlog::PostsShow
        mount MarionetteBlog::PostsUpdate
        mount MarionetteBlog::PostsDelete
      end
    end
  end
end
