module MarionetteBlog
  class PostsList < Grape::API
    desc 'Call to get all Posts'
    get do
      status 200
      posts = Interactors::ListPost.new.exec
      PostDecorator.decorate_response(posts)
    end
  end
end
