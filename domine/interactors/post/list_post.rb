module Interactors
  class ListPost < Utils::Interactor
    def exec
      posts = PostRepository.all 
      respond_with_success(posts, {scope: :posts})
    end
  end
end
