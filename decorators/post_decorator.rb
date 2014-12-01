# This class is in charge of Decorationg the Post
class PostDecorator < Decorator
  class << self
    # Decorates the Post
    def decorate_response(response)
      self.resource = :post
      super(response)
    end

    # Defines the single post decoration
    def decorate(item)
      {
        id:         item[:id],
        title:      item[:title],
        preface:    item[:preface],
        body:       item[:body],
        tags:       _compose_tags(item[:tags]),
        created_at: item[:created_at].iso8601
      }
    end

    def _compose_tags(tags)
      tags.map { |t| t[:name] }
    end
  end
end
