module MarionetteBlog
  class PostsShow < Grape::API
    get do
      post = Interactors::ShowPost.new({post: {id: params[:id]}}).exec
      status correct_status(post, 200)
      PostDecorator.decorate_response(post)
    end
  end
end
