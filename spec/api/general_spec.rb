require 'spec_helper'

describe MarionetteBlog::API do
  include Rack::Test::Methods

  def app
    MarionetteBlog::API
  end

  describe 'General Specs for the API' do
    describe 'Not Found' do
      context 'must return a 404 if the URL is not found' do
        it {
          get '/asfasfasdf'

          expect(last_response.status).to eq(404)
          expect(json).to eq({'error' => 'Not Found'})
        }
      end
    end
  end
end

