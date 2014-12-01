require 'spec_helper'

describe MarionetteBlog::API do
  include Rack::Test::Methods

  def app
    MarionetteBlog::API
  end

  describe 'Tags' do
    describe 'GET /tags/:name' do
      context 'must get all the posts filterd by tag' do
        let(:tag1)      { attributes_for(:tag, name: 'surf') }
        let(:tag2)      { attributes_for(:tag, name: 'eat') }
        let(:tag3)      { attributes_for(:tag, name: 'paly') }
        let!(:request)  { Helpers::Factories::Post.new_created_request(tags: [tag1[:name], tag2[:name]]) }
        let!(:request2) { Helpers::Factories::Post.new_created_request(tags: [tag1[:name], tag3[:name]]) }
        let!(:request3) { Helpers::Factories::Post.new_created_request(tags: [tag3[:name]]) }
        it {
          get '/tags/surf'

          expect(last_response.status).to eq(200)
          expect(json.count).to eq(2)
          expect(json.find_all{ |e| e['tags'].include?('surf')}.count).to eq(2)
        }
      end
    end
  end
end
