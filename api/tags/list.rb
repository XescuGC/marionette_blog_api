module MarionetteBlog
  class TagsShow < Grape::API
    desc 'Call to get all Posts with a Tag'
    get do
      status 200
      posts = Interactors::ListPost.new({filter: {tag: params[:name]}}).exec
      PostDecorator.decorate_response(posts)
    end
  end
end
