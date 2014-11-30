module MarionetteBlog
  class API < Grape::API
    format :json
    rescue_from Grape::Exceptions::ValidationErrors do |e|
      errors = []
      e.errors.each_pair do |k, v|
        match = k.match(/(?<resource>(.*))\[(?<attribute>(.*))\]/)
        errors << { field: match[:attribute], resource: match[:resource], code: 101}
      end
      Rack::Response.new([{message: "Params errors: #{e.message}", errors: errors}.to_json], 400).finish
    end


    mount MarionetteBlog::Posts

    route :any, '*path' do
      error!('Not Found', 404)
    end
  end
end
