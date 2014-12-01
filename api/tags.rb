module MarionetteBlog
  # Class that defines all the API calls
  # to interact with the Tags
  class Tags < Grape::API
    format :json

    resource :tags do
      route_param :name do
        mount MarionetteBlog::TagsShow
      end
    end
  end
end
