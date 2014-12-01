module MarionetteBlog
  class PostsList < Grape::API
    desc 'Call to get all Posts'
    get do
      status 200
      posts = if params[:tag]
                Interactors::ListPost.new({filter: {tag: params[:tag]}}).exec
              else
                Interactors::ListPost.new.exec
              end
      PostDecorator.decorate_response(posts)
    end
  end
end
