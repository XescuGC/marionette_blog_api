module MarionetteBlog
  module Helpers
    # Module that adds the Methos needed to set the correct HTTP status
    module StatusIndentifier
      def correct_status(entity, default)
        return default unless entity
        if entity.key?(:errors)
          if entity[:errors].find { |error| error[:code] == 105 }
            404
          else
            422
          end
        else
          default
        end
      end
    end
  end
end
