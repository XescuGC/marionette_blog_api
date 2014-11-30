module MarionetteBlog
  class Posts < Grape::API
    format :json

    resource :posts do
      get do
        status 200
        posts = Interactors::ListPost.new.exec
        PostDecorator.decorate_response(posts)
      end
      params do
        requires :post, type: Hash do
          requires :title,   type: String
          requires :body,    type: String
          requires :preface, type: String
          requires :tags,    type: Array
        end
      end
      post do
        status 201
        post = Interactors::CreatePost.new({post: params[:post]}).exec
        if post.key?(:errors)
          if post[:errors].find{ |error| error[:code] == 105 }
            status 404
          else
            status 422
          end
        end
        PostDecorator.decorate_response(post)
      end
      route_param :id do
        get do
          status 200
          post = Interactors::ShowPost.new({post: {id: params[:id]}}).exec
          PostDecorator.decorate_response(post)
        end
        put do
          status 200
          post_params = params[:post]
          post_params[:id] = params[:id]
          post = Interactors::UpdatePost.new({post: post_params}).exec
          PostDecorator.decorate_response(post)
        end
        delete do
          status 204
          post = Interactors::DeletePost.new({post: {id: params[:id]}}).exec
          PostDecorator.decorate_response(post)
        end
      end
    end
  end
end
