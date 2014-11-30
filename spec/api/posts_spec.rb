require 'spec_helper'

describe MarionetteBlog::API do
  include Rack::Test::Methods

  def app
    MarionetteBlog::API
  end

  describe 'Posts' do
    describe 'Not Found' do
      context 'must return a 404 if the URL is not found' do
        it {
          get '/asfasfasdf'

          expect(last_response.status).to eq(404)
          expect(json).to eq({'error' => 'Not Found'})
        }
      end
    end
    describe 'GET /posts' do
      let!(:request) { Helpers::Factories::Post.new_created_request }
      context 'must get all the posts' do
        it {
          get '/posts'

          expect(last_response.status).to eq(200)
          expect(json.is_a?(Array)).to be_truthy
          expect(json.count).to eq(1)
        }
      end
    end
    describe 'POST /posts' do
    end
    describe 'GET /posts/:id' do
    end
    describe 'PUT /posts/:id' do
    end
    describe 'DELETE /posts/:id' do
    end
  end
end
