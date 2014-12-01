module Interactors
  # This Interactors is in charge of Listing all Posts, it can work with no Hash for params, but if you whant to filter it you have to follow this structure:
  #   {
  #     filter: {
  #       tag: 'name'
  #     }
  #   }
  # 
  # The result will be always OK, even if it's an empty array []
  class ListPost < Utils::Interactor
    def exec
      if self.request[:filter]
        if self.request[:filter][:tag]
          posts = _retrive_post_filtered_by(:tag, self.request[:filter][:tag])
          respond_with_success(posts, {scope: :posts})
        end
      else
        posts = PostRepository.all 
        respond_with_success(posts, {scope: :posts})
      end
    end

    def _retrive_post_filtered_by(type, search)
      if type == :tag
        PostRepository.find_all_with_tag(tag: search)
      end
    end
  end
end
