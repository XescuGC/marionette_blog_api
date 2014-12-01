module MarionetteBlog
  class PostsDelete < Grape::API
    desc 'Call to Delete a Post'
    delete do
      post = Interactors::DeletePost.new({post: {id: params[:id]}}).exec
      status correct_status(post, 204)
      PostDecorator.decorate_response(post)
    end
  end
end
