module MarionetteBlog
  class Tags < Grape::API
    format :json

    resource :tags do
      route_param :name do
        mount MarionetteBlog::TagsShow
      end
    end
  end
end
