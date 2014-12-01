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
        post = Interactors::CreatePost.new({post: params[:post]}).exec
        status correct_status(post, 201)
        PostDecorator.decorate_response(post)
      end
      route_param :id do
        get do
          post = Interactors::ShowPost.new({post: {id: params[:id]}}).exec
          status correct_status(post, 200)
          PostDecorator.decorate_response(post)
        end
        params do
          requires :post, type: Hash do
            optional :title,   type: String
            optional :body,    type: String
            optional :preface, type: String
            optional :tags,    type: Array
          end
        end
        put do
          post_params = params[:post]
          post_params[:id] = params[:id]
          post = Interactors::UpdatePost.new({post: post_params}).exec
          status correct_status(post, 200)
          PostDecorator.decorate_response(post)
        end
        delete do
          post = Interactors::DeletePost.new({post: {id: params[:id]}}).exec
          status correct_status(post, 204)
          PostDecorator.decorate_response(post)
        end
      end
    end
  end
end
