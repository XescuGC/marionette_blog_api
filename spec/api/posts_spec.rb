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
      context 'must get all filtered posts' do
        let(:tag1)      { attributes_for(:tag, name: 'surf') }
        let(:tag2)      { attributes_for(:tag, name: 'eat') }
        let(:tag3)      { attributes_for(:tag, name: 'paly') }
        let!(:request)  { Helpers::Factories::Post.new_created_request(tags: [tag1[:name], tag2[:name]]) }
        let!(:request2) { Helpers::Factories::Post.new_created_request(tags: [tag1[:name], tag3[:name]]) }
        let!(:request3) { Helpers::Factories::Post.new_created_request(tags: [tag3[:name]]) }
        it {
          get '/posts?tag=surf'
          expect(json.count).to eq(2)
          expect(json.find_all{ |e| e['tags'].include?('surf')}.count).to eq(2)
        }
      end
    end
    describe 'POST /posts' do
      context 'must create a new Post' do
        let(:request) { Helpers::Factories::Post.new_request }
        it {
          before_count = PostRepository.all.count
          post '/posts', request

          expect(last_response.status).to eq(201)
          expect(json).to include("id")
          expect(PostRepository.all.count).to eq(before_count + 1)
        }
      end
      describe 'must return error' do
        context 'if the required params are missing' do
          let!(:request) { Helpers::Factories::Post.new_request }
          it {
            request[:post].delete(:title)
            request[:post].delete(:body)
            before_count = PostRepository.all.count
            post '/posts', request

            expect(last_response.status).to eq(400)
            expect(PostRepository.all.count).to eq(before_count)
          }
        end
        context 'if there was an error' do
          let(:request) { Helpers::Factories::Post.new_request }
          it {
            before_count = PostRepository.all.count
            request[:post][:title] = nil
            post '/posts', request

            expect(last_response.status).to eq(422)
            expect(PostRepository.all.count).to eq(before_count)
          }
        end
      end
    end
    describe 'GET /posts/:id' do
      context 'msut return a the same Post' do
        let(:request) { Helpers::Factories::Post.new_created_request }
        it {
          get '/posts/' + request[:post][:id]

          expect(last_response.status).to eq(200)
          expect(json['id']).to eq(request[:post][:id])
        }
      end
      context 'must return error if the post was not found' do
        it {
          get '/posts/' + '123'

          expect(last_response.status).to eq(404)
          expect(json).to include('errors')
        }
      end
    end
    describe 'PUT /posts/:id' do
      context 'must update the Post' do
        let(:request) { Helpers::Factories::Post.new_created_request }
        it {
          new_title = (0...8).map { (65 + rand(26)).chr }.join
          put '/posts/' + request[:post][:id], {post: {title: new_title}}

          expect(last_response.status).to eq(200)
          expect(json['id']).to eq(request[:post][:id])
          expect(json['title']).to eq(new_title)
        }
      end
      describe 'must return error' do
        context 'if the Post was not found' do
          it {
            put '/posts/' + '123', {post: {title: 'foo'}}

            expect(last_response.status).to eq(404)
            expect(json).to include('errors')
          }
        end
        context 'if there was an error' do
          let(:request) { Helpers::Factories::Post.new_created_request }
          it {
            request[:post][:title] = nil
            put '/posts/' + request[:post][:id], {post: {title: nil}}

            expect(last_response.status).to eq(422)
          }
        end
      end
    end
    describe 'DELETE /posts/:id' do
      context 'must delete the Post' do
        let!(:request) { Helpers::Factories::Post.new_created_request }
        it {
          before_count = PostRepository.all.count
          delete '/posts/' + request[:post][:id]

          expect(last_response.status).to eq(204)
          expect(last_response.body).to eq('')
          expect(PostRepository.all.count).to eq(before_count - 1)
        }
      end
      describe 'must return an error' do
        context 'if the Post was not found' do
          it {
            before_count = PostRepository.all.count
            delete '/posts/' + '123'

            expect(last_response.status).to eq(404)
            expect(PostRepository.all.count).to eq(before_count)
          }
        end
      end
    end
  end
end
