module MarionetteBlog
  class API < Grape::API
    format :json

    mount MarionetteBlog::Posts

    route :any, '*path' do
      error!('Not Found', 404)
    end
  end
end
