module Helpers
  module JsonHelper
    def json
      @json ||= JSON.parse(last_response.body)
    end
  end
end
